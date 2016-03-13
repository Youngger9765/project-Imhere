class AddShippingMethodToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_method, :string
    add_column :orders, :shipping_price, :string
  end
end
