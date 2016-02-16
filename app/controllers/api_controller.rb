class ApiController < ActionController::Base
  before_action :authenticate_user_from_token!

  def authenticate_user_from_token!

    if params[:auth_token].present?
      user = User.find_by_authentication_token(
                  params[:auth_token] )

      sign_in(user, store: false) if user
    else
      render :json => {
        :error => {
          :msg => "auth_token can't be blank!",         
        }
      }, :status => 401
    end
  end
end
