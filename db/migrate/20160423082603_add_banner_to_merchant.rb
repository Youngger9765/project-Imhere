class AddBannerToMerchant < ActiveRecord::Migration
  def change
    add_attachment :merchants, :banner
  end
end
