class AddFavoritingsCount < ActiveRecord::Migration
  def change
    add_column :activities, :favoritings_count, :integer, :default => 0
    add_column :users, :favoritings_count, :integer, :default => 0
  end
end
