class ApiV1::NotificationsController < ApiController

  before_action :authenticate_user_from_token!
  before_action :authenticate_user!

  def getTodayNotification
    @date_now = Time.now.to_date
    @notifications = Notification.where('start_time < ? AND start_time > ?', Time.now.end_of_day,Time.now.beginning_of_day).order("start_time ASC")
  end

  def getAlreadyNotification
    @notifications = Notification.where('start_time < ?', Time.now).order("start_time DESC")
  end

  def countNotificationBadge
    @user = current_user
    user_click_time = @user.click_notification_at
    notifications = Notification.where("start_time > ? AND start_time < ?", user_click_time,Time.now)
    @notification_badge_count = notifications.size

    render :json => {
            :notification_badge_count => @notification_badge_count
          }, :status => 200
  end

  def clickNotification
    user = current_user
    user.clean_notification_badge
    user.click_notification_at = Time.now
    user.save

    render :json => {
            :success => "記錄點擊推播"
          }, :status => 200
  end

end
