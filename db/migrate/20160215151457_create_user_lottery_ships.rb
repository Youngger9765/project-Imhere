class CreateUserLotteryShips < ActiveRecord::Migration
  def change
    create_table :user_lottery_ships do |t|
      t.integer :user_id
      t.integer :lottery_id
      t.timestamps null: false
    end

    add_index :user_lottery_ships, :user_id
    add_index :user_lottery_ships, :lottery_id
  end
end
