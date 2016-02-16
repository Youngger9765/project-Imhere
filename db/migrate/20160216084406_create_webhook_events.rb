class CreateWebhookEvents < ActiveRecord::Migration
  def change
    create_table :webhook_events do |t|
      t.text  :content
      t.timestamps null: false
    end
  end
end
