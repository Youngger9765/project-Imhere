class AddSponsorToMerchants < ActiveRecord::Migration
  def change
  	add_column :merchants, :sponsor, :string
  end
end
