class AddFulfillmentStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :fulfillment_status, :string
  end
end
