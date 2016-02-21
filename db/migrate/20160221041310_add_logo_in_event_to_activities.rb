class AddLogoInEventToActivities < ActiveRecord::Migration
  def change
    add_attachment :activities, :logo_in_event
  end
end
