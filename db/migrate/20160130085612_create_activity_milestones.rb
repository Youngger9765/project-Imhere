class CreateActivityMilestones < ActiveRecord::Migration
  def change
    create_table :activity_milestones do |t|
      t.integer :activity_id
      t.integer :people
      t.string  :content
      t.timestamps null: false
    end
  end
end
