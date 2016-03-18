class ChangeClickNotificationAtDefaultValue < ActiveRecord::Migration
  def change
    change_column :users, :click_notification_at, :datetime, :default => Time.now
    remove_column :users, :notification_badge

    users = User.where(:click_notification_at => nil)
    users.update_all(:click_notification_at => Time.now)
  end
end
