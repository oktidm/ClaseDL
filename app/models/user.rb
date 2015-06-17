class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, omniauth_providers: [:twitter, :facebook]

  enum role: [:moderator, :guest]
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :pins, dependent: :destroy
  has_many :votes
  has_many :voted_posts, through: :votes, :source => :post

  

  before_save :set_default_role

  def email_verified?
   return false if email.blank?
   return false if has_temporal_email?
   true
  end 

 private

 def has_temporal_email?
   email.split("@")[1] == "change-me.com"
 end

 def set_default_role
   self.role ||= :moderator
 end

end