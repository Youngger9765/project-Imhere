class ApiV1::MerchantsController < ApiController

  before_action :authenticate_user_from_token!, :except => [:show]

  def show
    @event = Event.find(params[:event_id])
    @activity = Activity.find(params[:activity_id])
    @merchant = Merchant.find(params[:id])
  end

  def getShopifyInfo
    if authenticate_user_from_token!
      @merchant = Merchant.find_by_id(params[:merchant_id])

      if @merchant
        @variant = @merchant.variants.find_by(:title => params[:options])
        if @variant.nil?
          render :json => {
            :error => "此商品無此組合"
          }, :status => 401
        else
        end
      else
        render :json => {
          :error => "merchant_id is wrong!"
        }, :status => 401
      end
      
    else
      render :json => {
        :error => "auth_token is wrong!!"
      }, :status => 422
    end
  end

  def getVariantInfo
    if authenticate_user_from_token!
      variant_id = params[:variant_id]
      @variant = Variant.find_by_shopify_variant_id(params[:variant_id])
      
    else
      render :json => {
        :error => "auth_token is wrong!!"
      }, :status => 422

    end
  end

  private

  def find_merchant!
    if params[:merchant_id].present?
      @merchant = Merchant.find_by_id(params[:merchant_id])
    else
      false
    end
  end
end
