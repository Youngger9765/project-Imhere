class Admin::OrdersController < ApplicationController

  layout "admin"
  before_action :authenticate_user! 
  before_action :user_admin?

  def index
    
  end
end
