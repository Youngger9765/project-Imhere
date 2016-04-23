class AddMerchantBannerToActivity < ActiveRecord::Migration
  def change
    add_attachment :activities, :merchant_banner
  end
end
