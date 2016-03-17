class AddFanPageNameToLottery < ActiveRecord::Migration
  def change
    add_column :lotteries, :fan_page_name, :string
  end
end
