class AddShopifyOrderIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shopify_order_id, :integer, :limit => 8
  end
end
