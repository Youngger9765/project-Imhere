class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :event_id
      t.string :name
      t.string :participator
      t.string :location
      t.datetime :start_time
      t.datetime :end_time
      t.text :content
      t.text :information
      t.integer :fund
      t.integer :shared_people
      t.integer :status
      t.timestamps null: false
    end

    add_index :activities, :event_id
  end
end