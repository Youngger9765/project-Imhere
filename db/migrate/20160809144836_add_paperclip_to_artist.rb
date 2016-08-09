class AddPaperclipToArtist < ActiveRecord::Migration
  def change
    add_attachment :artists, :logo
  end
end
