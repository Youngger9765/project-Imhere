class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_success
    render :file => "#{Rails.root}/public/200.html", :status => 200
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:account_update) << :name
    end

    def user_not_authorized(exception)
      redirect_to unauthorized_path  # 導向筆者剛剛新增的網頁
    end
    def user_admin?
      if current_user.admin?
      else
        redirect_to unauthorized_path
      end
    end
end
