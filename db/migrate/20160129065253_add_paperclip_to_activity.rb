class AddPaperclipToActivity < ActiveRecord::Migration
  def change
    add_attachment :activities, :logo
    add_attachment :activities, :information_picture
  end
end
