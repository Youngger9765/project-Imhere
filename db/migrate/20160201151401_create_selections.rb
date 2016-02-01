class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.integer :spec_id
      t.string  :name
      t.timestamps null: false
    end
  end
end
