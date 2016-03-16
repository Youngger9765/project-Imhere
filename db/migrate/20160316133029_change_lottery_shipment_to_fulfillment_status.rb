class ChangeLotteryShipmentToFulfillmentStatus < ActiveRecord::Migration
  def change
     add_column :lotteries, :fulfillment_status, :string
     remove_column :lotteries, :shipment
  end
end
