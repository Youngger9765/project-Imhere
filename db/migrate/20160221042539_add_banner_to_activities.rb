class AddBannerToActivities < ActiveRecord::Migration
  def change
    add_attachment :activities, :banner
  end
end
