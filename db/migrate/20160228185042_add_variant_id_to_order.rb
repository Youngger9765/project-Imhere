class AddVariantIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :product_variant_id, :integer, :limit => 8
  end
end
