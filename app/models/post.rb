class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :votes
	has_many :users_who_voted, through: :votes, :source => :user
	mount_uploader :photo, PictureUploader
end
