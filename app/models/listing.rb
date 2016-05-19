class Listing < ActiveRecord::Base
	belongs_to :user, :dependent => :destroy
	has_many :bids
  	mount_uploader :image, ImageUploader
end
