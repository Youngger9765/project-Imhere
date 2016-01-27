class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :event_id
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.text :content
      t.integer :fund
      t.integer :shared_people
      t.timestamps null: false
    end

    add_index :activities, :event_id
  end
end