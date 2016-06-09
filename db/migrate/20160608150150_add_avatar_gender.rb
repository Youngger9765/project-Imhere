class AddAvatarGender < ActiveRecord::Migration
  def change
    add_column :users, :avatar_gender, :string
  end
end
