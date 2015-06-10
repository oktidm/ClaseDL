class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  enum role: [:moderator, :guest]
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :pins, dependent: :destroy

  before_save :set_default_role

  def set_default_role
  	self.role ||= :moderator
  end

end
