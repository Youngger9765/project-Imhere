class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :fb_link
      t.string :youtube_link
      t.string :ig_link
      t.string :webo_link

      t.timestamps null: false
    end

    add_index :artists, :name
  end
end
