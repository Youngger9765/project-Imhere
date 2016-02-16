class UserLotteryShip < ActiveRecord::Base

  belongs_to :user
  belongs_to :lottery, counter_cache: :users_count
end
