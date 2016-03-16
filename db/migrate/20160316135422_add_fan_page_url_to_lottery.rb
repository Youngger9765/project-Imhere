class AddFanPageUrlToLottery < ActiveRecord::Migration
  def change
    add_column :lotteries, :fan_page_url, :string
  end
end
