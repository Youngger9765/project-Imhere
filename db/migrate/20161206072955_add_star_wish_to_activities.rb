class AddStarWishToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :star_wish_name, :string
  end
end
