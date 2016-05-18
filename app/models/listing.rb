class Listing < ActiveRecord::Base
	belongs_to :user, :dependent => :destroy
	has_many :bids
end
