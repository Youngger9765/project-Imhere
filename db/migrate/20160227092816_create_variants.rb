class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer :merchant_id
      t.integer :shopify_variant_id, :limit => 8
      t.string  :title
      t.integer :price
      t.float :weight
      t.string  :weight_unit

      t.timestamps null: false
    end

    add_index :variants, :merchant_id
    add_index :variants, :shopify_variant_id
  end
end
