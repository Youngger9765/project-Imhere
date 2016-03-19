class AddCancelAtToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :cancelled_at, :datetime
  end
end
