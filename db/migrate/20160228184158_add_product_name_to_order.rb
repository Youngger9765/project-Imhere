class AddProductNameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :product_name, :string 
  end
end
