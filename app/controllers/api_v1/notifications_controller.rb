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
    user = current_user
    notifications = Notification.where("start_time < ?",Time.now)

    # normal & limited
    normal_notifications = notifications.where(:countdown_end_time => nil)
    limited_notifications = notifications.where.not(:countdown_end_time => nil)

    @normal_notification_badge_count = 0
    @limited_notification_badge_count = 0

    normal_notifications.each do |notification|
      if !notification.user_clicked_list.include?(user.id.to_s)
        @normal_notification_badge_count += 1
      end
    end

    limited_notifications.each do |notification|
      if !notification.user_clicked_list.include?(user.id.to_s)
        @limited_notification_badge_count += 1
      end
    end

    render :json => {
            :normal_notification_badge_count => @normal_notification_badge_count,
            :limited_notification_badge_count => @limited_notification_badge_count
          }, :status => 200
  end

  def clickNotification
    user = current_user
    user.click_notification_at = Time.now
    user.save

    # optional: if user click the specific item
    if params[:notification_id] && !params[:notification_id].include?(".") && params[:notification_id].to_i != 0
      if Notification.where(:id => params[:notification_id]).size == 1
        notification = Notification.find(params[:notification_id])
        user_clicked_list = notification.user_clicked_list

        if !user_clicked_list.include?(user.id.to_s)
          user_clicked_list << user.id
          notification.save!
        end

        render :json => {
              :success => "記錄特定推播點擊"
            }, :status => 200
      else
        render :json => {
              :error => "notification not include this id!"
            }, :status => 401
      end

    # all shown normal nortification.user_clicked_list add user.id
    elsif params[:notification_id] && params[:notification_id] == "normal"
      notifications = Notification.where('start_time < ?', Time.now)
      normal_notifications = notifications.where(:countdown_end_time => nil)

      normal_notifications.each do |notification|
        if !notification.user_clicked_list.include?(user.id.to_s)
          notification.user_clicked_list << user.id
          notification.save!
        end
      end

      render :json => {
            :success => "記錄一般推播點擊"
          }, :status => 200

    else
      render :json => {
            :erroe => "請確認 notification_id (整數或'normal')"
          }, :status => 401
    end


    
  end

end
