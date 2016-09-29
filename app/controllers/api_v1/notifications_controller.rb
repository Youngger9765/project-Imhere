class ApiV1::NotificationsController < ApiController

  before_action :authenticate_user_from_token!
  before_action :authenticate_user!

  def getTodayNotification
    @user = current_user
    @date_now = Time.now.to_date
    @notifications = Notification.where('start_time < ? AND start_time > ?', Time.now.end_of_day,Time.now.beginning_of_day).order("start_time ASC")
    @normal_notifications = @notifications.where(:countdown_end_time => nil)
    @limited_notifications = @notifications.where.not(:countdown_end_time => nil)
  end

  def getAlreadyNotification
    @user = current_user
    @notifications = Notification.where('start_time < ?', Time.now).order("start_time DESC")
    @normal_notifications = @notifications.where(:countdown_end_time => nil)
    @limited_notifications = @notifications.where.not(:countdown_end_time => nil)
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
    user.click_notification_at = Time.now
    user.save

    # optional: if user click the specific item
    if params[:notification_id]
      notification = Notification.find(params[:notification_id])
      user_clicked_list = notification.user_clicked_list

      if !user_clicked_list.include?(user.id)
        user_clicked_list << user.id
        notification.save!
      end
    end


    render :json => {
            :success => "記錄特定點擊推播"
          }, :status => 200
  end

end
