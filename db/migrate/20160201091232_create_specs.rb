class CreateSpecs < ActiveRecord::Migration
  def change
    create_table :specs do |t|
      t.integer :merchant_id
      t.string  :name
      t.string  :selection
      t.timestamps null: false
    end
  end
end
