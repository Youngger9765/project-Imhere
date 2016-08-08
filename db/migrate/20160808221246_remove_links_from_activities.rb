class RemoveLinksFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :fb_link, :string
    remove_column :activities, :youtube_link, :string
    remove_column :activities, :ig_link, :string
    remove_column :activities, :webo_link, :string
  end
end
