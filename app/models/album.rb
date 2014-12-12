class Album < ActiveRecord::Base

  has_many :photos
  has_many :share_albums
  has_many :comments , through: :photos
  belongs_to :user
   validates :title, uniqueness:true
   validates :title, :describtion, presence:true,length: { minimum: 5}
    
  before_validation :check 

    def check
      title = describtion if title.blank?
    end
end

