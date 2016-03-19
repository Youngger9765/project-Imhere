class ApiV1::OrdersController < ApiController

  before_action :authenticate_user_from_token!
  before_action :authenticate_user!

  def userCancelOrder

    if authenticate_user_from_token!
      order = Order.find_by(:shopify_order_id => params[:shopify_order_id])


      if order.nil?
        
        render :json => {
          :error => "shopify_order_id 錯誤！"
        }, :status => 401
      
      else
        user = User.find_by(:authentication_token => params[:auth_token])
        if order.user != user
          render :json => {
            :error => "此訂單不屬於此用戶"
          }, :status => 401

        else
          shopify_here_order_action_config = YAML.load(File.read("#{Rails.root}/config/shopify_here_order_action.yaml"))[Rails.env]
          order_config = shopify_here_order_action_config
          url = "https://"+order_config["api_key"]+":"+ order_config["password"]+"@"+order_config["store"]+"/admin/orders/#{params[:shopify_order_id]}/cancel.json"
          res = RestClient.post url, :param1 => 'one'
          
          render :json => {
            :massage => "訂單已刪除",
            :response => res
          }, :status => 200

        end
      end
    end
  end

end
