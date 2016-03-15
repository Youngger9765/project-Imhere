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

end
