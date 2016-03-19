class AddUrlToLottery < ActiveRecord::Migration
  def change
    add_column :lotteries, :url, :string
  end
end
