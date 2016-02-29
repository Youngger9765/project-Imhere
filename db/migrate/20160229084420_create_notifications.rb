class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string    :title
      t.datetime  :start_time
      t.text      :content
      t.string    :url
      t.timestamps null: false
    end

    add_attachment :notifications, :logo
  end
end
