class Bid < ActiveRecord::Base
  belongs_to :listing, :dependent => :destroy
  belongs_to :user, :dependent => :destroy
  validates :bid_price, :presence => true

end