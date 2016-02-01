class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string  :merchantable_type
      t.integer :merchantable_id
      t.text    :description
      t.string  :name
      t.text    :content
      t.integer :price
      t.timestamps null: false
    end
  end
end
