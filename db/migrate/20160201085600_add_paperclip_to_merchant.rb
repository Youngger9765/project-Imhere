class AddPaperclipToMerchant < ActiveRecord::Migration
  def change
    add_attachment :merchants, :logo
  end
end
