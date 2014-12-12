class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	  validates :user_name, presence:true,length: { minimum: 5}
	  


  has_many :share_albums
  has_many :albums
  has_many :photos, through: :albums
  has_many :comments, through: :photos
end
