class PushTimeToLottery < ActiveRecord::Migration
  def change
    add_column :lotteries, :push_time, :datetime

    Lottery.all.each do |l|
      l.update(:push_time => l.created_at)
    end
  end
end
