class AddDescriptionToLottery < ActiveRecord::Migration
  def change
    add_column :lotteries, :description, :text
  end
end
