class AddWinnerToLotteryUserShips < ActiveRecord::Migration
  def change
    add_column :user_lottery_ships, :winner, :integer, :default => 0
    add_column :lotteries, :got_winner, :integer, :default => 0
  end
end
