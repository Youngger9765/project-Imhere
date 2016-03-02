class AddFbDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :fb_email, :string
    add_column :users, :fb_name, :string
    add_column :users, :fb_head_shot, :string
  end
end
