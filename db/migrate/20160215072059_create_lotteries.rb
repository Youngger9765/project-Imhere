class CreateLotteries < ActiveRecord::Migration
  def change
    create_table :lotteries do |t|
      t.integer :activity_id
      t.string  :name
      t.text    :content
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps null: false
    end
  end
end
