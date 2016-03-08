class ApiController < ActionController::Base

  def authenticate_user_from_token!

    if params[:auth_token].present?
      user = User.find_by_authentication_token(
                  params[:auth_token] )

      sign_in(user, store: false) if user
    else
      render :json => {
        :error => {
          :msg => "auth_token 錯誤！",         
        }
      }, :status => 401
    end
  end
end
