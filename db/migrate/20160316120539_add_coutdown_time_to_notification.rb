class AddCoutdownTimeToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :countdown_end_time, :datetime
  end
end
