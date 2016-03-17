class AddNotificationBadgeToUser < ActiveRecord::Migration
  def change
    add_column :users, :click_notification_at, :datetime
    add_column :users, :notification_badge, :integer, :default => 0
  end
end
