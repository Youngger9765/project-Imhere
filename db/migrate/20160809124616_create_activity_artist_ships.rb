class CreateActivityArtistShips < ActiveRecord::Migration
  def change
    create_table :activity_artist_ships do |t|
      t.integer :activity_id
      t.integer :artist_id      

      t.timestamps null: false
    end

    add_index :activity_artist_ships, :activity_id
    add_index :activity_artist_ships, :artist_id
  end
end
