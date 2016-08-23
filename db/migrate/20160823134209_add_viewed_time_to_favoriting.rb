class AddViewedTimeToFavoriting < ActiveRecord::Migration
  def change
    add_column :user_activity_favoritings, :last_view_time, :datetime
  end
end
