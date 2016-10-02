class AddSubdomainToUser < ActiveRecord::Migration
  def change
  	add_column :users, :mail_subdomain, :string
  end
end
