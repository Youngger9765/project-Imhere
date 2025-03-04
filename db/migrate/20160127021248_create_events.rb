class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :banner
      t.datetime :start_time
      t.datetime :end_time
      t.text :content
      t.integer :shared_people
      t.timestamps null: false
    end
  end
end
