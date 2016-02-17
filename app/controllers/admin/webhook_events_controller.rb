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
    data = ActiveSupport::JSON.decode(request.body.read)

    webhook_event = WebhookEvent.create(:content => data)
    webhook_event.save!

    lottery = Lottery.create(:name => data)

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
