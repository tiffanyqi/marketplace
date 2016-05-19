class Bid < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user
  validates :bid_price, :presence => true

end