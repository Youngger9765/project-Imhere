class AddShopifyProductInfoToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :shopify_product_id, :integer, :limit => 8
    add_column :merchants, :vendor, :string

    add_index :merchants, :shopify_product_id
    add_index :merchants, :vendor
  end
end
