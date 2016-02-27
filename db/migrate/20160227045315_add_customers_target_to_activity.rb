class AddCustomersTargetToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :customers_target, :integer
  end
end
