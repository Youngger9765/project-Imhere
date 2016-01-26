class ApiV1::AuthController < ApiController

    # required user login for logout action
  before_action :authenticate_user!, :except => [:login, :register]
  before_action :authenticate_user_from_token!, :except => [:login, :register]

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
