class ActivityArtistShip < ActiveRecord::Base
  belongs_to :activity
  belongs_to :artist
end
