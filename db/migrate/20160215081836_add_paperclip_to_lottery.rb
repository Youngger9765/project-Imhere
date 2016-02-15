class AddPaperclipToLottery < ActiveRecord::Migration
  def change
    add_attachment :lotteries, :logo
  end
end
