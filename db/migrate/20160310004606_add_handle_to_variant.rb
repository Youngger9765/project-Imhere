class AddHandleToVariant < ActiveRecord::Migration
  def change
    add_column :variants, :handle, :string
  end
end
