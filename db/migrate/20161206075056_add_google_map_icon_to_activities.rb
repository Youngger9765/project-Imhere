class AddGoogleMapIconToActivities < ActiveRecord::Migration
  def change
  	 add_attachment :activities, :google_map_icon
  end
end
