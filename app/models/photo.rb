class Photo < ActiveRecord::Base
  has_attached_file :avatar
   
  validates_attachment_presence :avatar

  has_many :comments
  belongs_to :album
  validates_attachment_content_type :avatar, :content_type => %w(image/jpeg image/jpg image/png)
end



