class ChangeBannerToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :banner
    add_attachment :events, :banner
  end
end
