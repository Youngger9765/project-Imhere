class AddUsersCountToLottery < ActiveRecord::Migration
  def change
    add_column :lotteries, :users_count, :integer, :default => 0

    Lottery.pluck(:id).each do |i|
      Lottery.reset_counters(i, :users) # 全部重算一次
    end
  end
end
