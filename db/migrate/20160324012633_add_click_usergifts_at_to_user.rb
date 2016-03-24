class AddClickUsergiftsAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :click_user_gifts_at, :datetime, :default => Time.now
    add_column :users, :click_user_miss_gifts_at, :datetime, :default => Time.now
  end
end
