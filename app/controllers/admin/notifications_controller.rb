class Admin::NotificationsController < ApplicationController

  layout "admin"
  before_action :authenticate_user! 
  before_action :user_admin?
  before_action :find_notification, :only => [:show, :edit, :update, :destroy]

  def index
    @time_now = Time.now

    if params[:filter] == "overtime"
      @notifications = Notification.where('start_time < ?', Time.now).order("start_time ASC")
      
    elsif params[:filter] == "latest"
      @notifications = Notification.where('start_time >= ?', Time.now).order("start_time ASC")

    elsif params[:filter] == "today"
      @notifications = Notification.where('start_time < ? AND start_time > ?', Time.now.end_of_day,Time.now.beginning_of_day).order("start_time ASC")

    else
      @notifications = Notification.all.order("start_time ASC")
    end
  end

  def show
  end

  def new
    @notification = Notification.new
    @check_tag = false
  end

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      if params[:no_countdown] == "1"
        @notification.countdown_end_time = nil
        @notification.save!
      end
      flash[:notice] = "推播建立成功!"
      redirect_to admin_notification_path(@notification)
    else
      flash[:alert] = "推播建立失敗!"
      render :new
    end
  end

  def edit
    if @notification.countdown_end_time.nil?
      @check_tag = true
    else
      @check_tag = false
    end

  end

  def update
    @notification.update(notification_params)

    if params[:destroy_logo] == "1"
      @notification.logo = nil
      @notification.save!
    end

    if params[:no_countdown] == "1"
      @notification.countdown_end_time = nil
      @notification.save!
    end

    redirect_to admin_notification_path(@notification)
  end

  def destroy
    @notification.destroy!
    redirect_to admin_notifications_path
  end

  private

  def notification_params
    params.require(:notification).permit( :title, :start_time, :logo, :content, :url, :countdown_end_time)
  end

  def find_notification
    @notification = Notification.find(params[:id])
  end
end
