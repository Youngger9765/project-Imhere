class AddMilestoneLogoContentToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :milestone_logo_content, :text
  end
end
