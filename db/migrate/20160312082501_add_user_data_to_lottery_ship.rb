class AddUserDataToLotteryShip < ActiveRecord::Migration
  def change
    add_column :user_lottery_ships, :user_name, :string
    add_column :user_lottery_ships, :user_address, :string
    add_column :user_lottery_ships, :user_phone_number, :string
    add_column :user_lottery_ships, :user_birthday, :datetime
    
  end
end
