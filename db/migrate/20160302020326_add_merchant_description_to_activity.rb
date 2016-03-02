class AddMerchantDescriptionToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :merchant_description, :text

    remove_column :merchants, :description
  end
end
