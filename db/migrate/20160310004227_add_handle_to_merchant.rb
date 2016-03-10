class AddHandleToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :handle, :string
  end
end
