class AddOrdersCountToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :orders_count, :integer, :default => 0         
    
    Merchant.pluck(:id).each do |i|       
      Merchant.reset_counters(i, :orders) # 全部重算一次     
    end
  end
end
