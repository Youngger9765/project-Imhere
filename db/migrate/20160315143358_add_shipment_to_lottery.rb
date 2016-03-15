class AddShipmentToLottery < ActiveRecord::Migration
  def change
    add_column :lotteries, :shipment, :integer, :default => 0
  end
end
