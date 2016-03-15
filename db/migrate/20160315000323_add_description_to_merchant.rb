class AddDescriptionToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :description, :text
  end
end
