class ApiV1::UsersController < ApiController

  before_action :authenticate_user!
  before_action :authenticate_user_from_token!

  def getUserInfo
    if authenticate_user_from_token!
      @user = current_user
    end
  end

  def editUserInfo
    if authenticate_user_from_token!
      @user = current_user
      @user.update(user_params)
    else
      render :json => {
        :error => {
          :msg => "auth_token is wrong!",         
        }
      }, :status => 401
    end 
  end 

  private

  def user_params
    params.require(:user).permit(:name, :phone_number ,:address)
  end


end
