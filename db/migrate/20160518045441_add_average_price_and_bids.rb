class AddAveragePriceAndBids < ActiveRecord::Migration
  def change
  	add_column :listings, :average_price, :integer
  end
end
