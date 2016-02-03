class Admin::UsersController < ApplicationController

  layout "admin"
  #before_action :user_admin?
  before_action :find_user, :only => [:update]

  def index
    @users = User.all.order("role_id DESC")
  end

  def update
    @user.role_id = params[:user][:role_id].to_i
    @user.save!
    
    redirect_to admin_users_path
  end

  private

  def user_admin?
    if current_user.admin?
    else
      redirect_to unauthorized_path
    end
  end

  def find_user
    @user = User.find(params[:id])
  end
end
