class AddUserClickedToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :user_clicked_list, :text, array:true, default: []
  end
end
