class AddSubdomainToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :subdomain, :string
  end
end
