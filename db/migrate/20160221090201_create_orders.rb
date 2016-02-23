class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :order_number
      t.string  :user_auth
      t.integer :user_id
      t.integer :product_id, :limit => 8
      t.string  :product_variant_title
      t.integer :product_quantity
      t.string  :product_price
      t.string  :subtotal_price
      t.string  :currency
      t.timestamps null: false
    end

    add_index :orders, :order_number
    add_index :orders, :user_auth
    add_index :orders, :user_id
    add_index :orders, :product_id
  end
end
