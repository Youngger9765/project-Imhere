class Attachment < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
end
