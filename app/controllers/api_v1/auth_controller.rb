class ApiV1::AuthController < ApiController

    # required user login for logout action
  before_action :authenticate_user!, :except => [:login, :register]

  def register
    user = User.find_by_email( params[:email] )
    if user
      render :json => {
        :error => {
          :msg => "Your email is already registered",         
        }
      }, :status => 401
    else
      user = User.new
      email = params[:email].downcase
      password = params[:password]
      password_confirmation = params[:password_confirmation]
      user.email = email
      user.password = password
      user.password_confirmation = password_confirmation
      user.authentication_token = user.generate_authentication_token
  
      if user.save
        render :json => {
          :member => {
            "message" => "Ok",
            "auth_token" => user.authentication_token,
            "user_id" => user.id
          }
        }, :status => 200
      else
        render :json => {
          :error => {
            "message" => "fail"
          }
        }, :status => 401
      end
    end  
  end

  def login
    user = User.find_by_email( params[:email] )

    if user && user.valid_password?( params[:password] )
      render :json => {
        :member => {
          "message" => "Ok",
          "auth_token" => user.authentication_token,
          "user_id" => user.id
        }
      }, :status => 200
      
    else
      render :json => {
        :error => {
          :msg => "Your email or password is wrong",         
        }
      }, :status => 401
    end

  end

  def logout
    current_user.generate_authentication_token
    current_user.save!

    render :json => { :message => "You are logout"}
  end
end
