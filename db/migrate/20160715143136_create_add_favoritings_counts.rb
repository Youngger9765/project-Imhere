class CreateAddFavoritingsCounts < ActiveRecord::Migration
  def change
    create_table :add_favoritings_counts do |t|
      add_column :activities, :favoritings_count, :integer, :default => 0
      add_column :users, :favoritings_count, :integer, :default => 0
      t.timestamps null: false
    end
  end
end
