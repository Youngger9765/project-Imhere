class Admin::WebhookEventsController < ApplicationController

  #before_filter :verify_webhook, :except => 'verify_webhook'

  def test
    puts "Webhook verified: #{data}"
  end

  def order_create
    data = ActiveSupport::JSON.decode(request.body.read)

    webhook_event = WebhookEvent.create(:content => data)
    webhook_event.save!

    lottery = Lottery.create(:name => data)

  end


  private

  def verify_webhook
    puts "=========================="
    puts "=========================="
    puts "=========================="
    data = request.body.read.to_s
    hmac_header = request.headers['HTTP_X_SHOPIFY_HMAC_SHA256']
    digest  = OpenSSL::Digest::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, SyncApp::Application.config.shopify.secret, data)).strip
    unless calculated_hmac == hmac_header
      head :unauthorized
    end
    request.body.rewind
  end

end
