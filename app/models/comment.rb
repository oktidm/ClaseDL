class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  mount_uploader :photo, PictureUploader
end
