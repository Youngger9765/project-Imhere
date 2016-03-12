class AddWinPeopleToLottery < ActiveRecord::Migration
  def change
    add_column :lotteries, :win_people, :integer, :default => 0
  end
end
