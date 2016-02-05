class ApiV1::AuthController < ApiController

  # required user login for logout action
  before_action :authenticate_user_from_token!, :except => [:login, :register, :reSendConfirmation,:sendResetPassword]
  before_action :authenticate_user!, :except => [:login, :register,:reSendConfirmation,:sendResetPassword]


  def register
    user = User.find_by_email( params[:email].downcase )

    if params[:email].blank?
      render :json => {
        :error => {
          :msg => "email is nil",
        }
      }, :status => 401

    elsif params[:password].blank? || params[:password].size < 8
      render :json => {
        :error => {
          :msg => "password is nil or less than 8",
        }
      }, :status => 401

    elsif params[:name].blank?
      render :json => {
        :error => {
          :msg => "name is nil",
        }
      }, :status => 401
    elsif user
      render :json => {
        :error => {
          :msg => "Your email is already registered",
        }
      }, :status => 401

    else
      user = User.new
      email = params[:email].downcase
      password = params[:password]
      name = params[:name]
      user.email = email
      user.password = password
      user.name = name
      user.authentication_token = user.generate_authentication_token

      if user.save
        render :json => {
          :member => {
            "msg" => "You have to confirm your email address before continuing.",
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
    success = false

    if params[:email] && params[:password]
      user = User.find_by_email( params[:email] )
      success = user && user.valid_password?( params[:password] )
    elsif params[:access_token]

      fb_data = User.get_fb_data( params[:access_token] )

      if fb_data
        auth_hash = OmniAuth::AuthHash.new({
          uid: fb_data["id"],
          info: {
            email: fb_data["email"],
            name: fb_data["name"]
          },
          credentials: {
            token: params[:access_token],
            expires_at: Time.now + 60.days
          }
        })

        user = User.from_omniauth(auth_hash)
      end

      success = fb_data && user.persisted?
    end

    if success
      sign_in(user, store: false) if user
      render :json => { :message => "login Ok",
                        :auth_token => user.authentication_token,
                        :user_id => user.id,
                        :email => user.email
                      }
    else
      render :json => { :message => "Email or Password is wrong",
                        :fb_data => fb_data
                        }, :status => 401
    end

  end

  def logout
    if params[:auth_token].present?
      user = User.find_by_authentication_token( params[:auth_token] )
      user.generate_authentication_token
      user.save!

      sign_out(user) if user
    end



    render :json => { :message => "You are logout"}
  end

  def reSendConfirmation
    user = User.find_by(:email => params[:email])

    if user
      user.resend_confirmation_instructions
      render :json => { :message => "確認信已發出至指定信箱"}
    else
      render :json => { :error => "該信箱未註冊或非法，請先註冊一個帳號"}, :status => 400
    end
  end

  def sendResetPassword
    user = User.find_by(:email => params[:email])

    if user
      user.send_reset_password_instructions
      render :json => { :message => "更改密碼確認信已發出至指定信箱"}
    else
      render :json => { :error => "該信箱未註冊或非法，請先註冊一個帳號"}, :status => 400
    end
  end
end
