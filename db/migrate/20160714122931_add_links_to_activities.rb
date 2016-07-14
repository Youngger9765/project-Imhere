class AddLinksToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :fb_link, :string
    add_column :activities, :youtube_link, :string
    add_column :activities, :ig_link, :string
    add_column :activities, :webo_link, :string
  end
end
