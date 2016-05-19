class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :bids
	mount_uploader :image, ImageUploader
	validates :title, :description, :image, :price, :presence => true
end
