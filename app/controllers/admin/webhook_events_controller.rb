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
    
    if order
      order = Order.find_by(:order_number => params[:order_number])
    else  
      order = Order.new
    end
    
    order.order_number = params[:order_number]
    order.product_id = params[:line_items][0][:product_id]
    order.product_variant_title = params[:line_items][0][:variant_title]
    order.product_quantity = params[:line_items][0][:quantity]
    order.product_price = params[:line_items][0][:price]
    order.subtotal_price = params[:subtotal_price]
    order.currency = params[:currency]
    order.save!

    head :ok
  end

  def product_create
    merchant = Merchant.find_by(:shopify_product_id => params[:id])
    
    if merchant
      merchant = Merchant.find_by(:shopify_product_id => params[:id])
    else  
      merchant = Merchant.new
    end

    merchant.shopify_product_id = params[:id]
    merchant.vendor = params[:vendor]
    merchant.name = params[:title]
    merchant.price = params[:variants][0][:price]
    
    if !params[:body_html].blank?
      merchant.content = params[:body_html]
    end

    merchant.save!

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
