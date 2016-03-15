class Admin::WebhookEventsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :verify_webhook, :except => [:verify_webhook, :dev_test]

  def test
    logger.debug "enter test"
    data = ActiveSupport::JSON.decode(request.body.read)
    logger.debug "Webhook verified:#{data}"

    head :ok
  end

  def dev_test
    logger.debug "enter dev_test========="
    data = params[:data]
    logger.debug "Webhook verified:#{data}"

    render :json => {
              :msg => "#{data}",
            }, :status => 200

  end

  def order_create
    order = Order.find_by(:order_number => params[:order_number])
    
    if order  #update
      order = Order.find_by(:order_number => params[:order_number])
    else  
      merchant = Merchant.find_by(:shopify_product_id => params[:line_items][0][:product_id])
      order = merchant.orders.new
    end
    
    order.shopify_order_id = params[:id]
    order.order_number = params[:order_number]

    if params[:shipping_lines]
      order.shipping_method = params[:shipping_lines][0][:title]
      order.shipping_price = params[:shipping_lines][0][:price]
    end
    
    order.product_id = params[:line_items][0][:product_id]
    order.product_name = params[:line_items][0][:title]
    order.product_variant_id = params[:line_items][0][:variant_id]
    order.product_variant_title = params[:line_items][0][:variant_title]
    order.product_quantity = params[:line_items][0][:quantity]
    order.product_price = params[:line_items][0][:price]
    order.subtotal_price = params[:subtotal_price]
    order.total_price = params[:total_price]
    order.currency = params[:currency]
    order.save!

    head :ok
  end

  def order_delete
    order = Order.find_by(:shopify_order_id => params[:id])
    
    if order
      order.destroy
    end
    
    head :ok 
    
  end

  def product_create_update
    #create merchant
    merchant = Merchant.find_by(:shopify_product_id => params[:id])
    
    if merchant
      merchant = Merchant.find_by(:shopify_product_id => params[:id])
    else  
      merchant = Merchant.new
    end

    merchant.shopify_product_id = params[:id]
    merchant.handle = params[:handle]
    merchant.vendor = params[:vendor]
    merchant.name = params[:title]
    merchant.price = params[:variants][0][:price]
    
    if !params[:body_html].blank?
      merchant.description = params[:body_html]
    end

    merchant.save!

    #create variant
    merchant.variants.delete_all
    params[:variants].each do |variant|
      @variant = merchant.variants.find_by(:shopify_variant_id => variant[:id])

      if @variant 
        @variant = merchant.variants.find_by(:shopify_variant_id => variant[:id])
      else
        @variant = merchant.variants.new
      end

      @variant.shopify_variant_id = variant[:id]
      @variant.title = variant[:title]
      @variant.handle = params[:handle]
      @variant.price = variant[:price]
      @variant.weight = variant[:weight]
      @variant.weight_unit = variant[:weight_unit]
      @variant.save!
    end

    #create spec & selection
    merchant.specs.destroy_all
    if !params[:options].blank?
      params[:options].each do |option|
        spec = merchant.specs.new
        spec.name = option[:name]
        spec.save!

        option[:values].each do |value|
          selection = spec.selections.new
          selection.name = value
          selection.save!
        end
      end
    end

    head :ok
  end

  def product_delete
    merchant = Merchant.find_by(:shopify_product_id => params[:id])

    if merchant
      merchant.destroy
    end
    
    head :ok   
  end 


  private

  def verify_webhook
    logger.debug  "===============verify_webhook==========="
    shopify_webhook_config = YAML.load(File.read("#{Rails.root}/config/shopify_webhook_secret.yml"))[Rails.env]
    data = request.body.read.to_s
    hmac_header = request.headers['HTTP_X_SHOPIFY_HMAC_SHA256']
    digest  = OpenSSL::Digest::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, shopify_webhook_config["secret"], data)).strip
    
    logger.debug "hmac_header: #{hmac_header}"
    logger.debug "calculated_hmac: #{calculated_hmac}"

    unless calculated_hmac == hmac_header
      head :unauthorized
    end
    
    if calculated_hmac == hmac_header
      Rails.logger.warn "You are verified now done============="
    end

    request.body.rewind
  end

end
