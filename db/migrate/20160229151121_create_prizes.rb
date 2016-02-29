class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.integer   :lottery_id
      t.string    :name
      t.text      :content
      t.float     :price
      t.integer   :quatity
      t.string    :brand
      t.string    :vendor
      t.timestamps null: false
    end
  end
end
