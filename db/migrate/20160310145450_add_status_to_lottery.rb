class AddStatusToLottery < ActiveRecord::Migration
  def change
    add_column :lotteries, :status, :integer, :default => 0
  end
end
