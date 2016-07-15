class CreateUserActivityFavoritings < ActiveRecord::Migration
  def change
    create_table :user_activity_favoritings do |t|
      t.integer :user_id
      t.integer :activity_id

      t.timestamps null: false
    end
  end
end
