class AddHeadShotBirthdayToUser < ActiveRecord::Migration
  def change
    add_attachment :users, :head_shot
    add_column :users, :birthday, :datetime
  end
end
