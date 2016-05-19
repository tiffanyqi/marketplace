class ChangeTypePrices < ActiveRecord::Migration
  def change
  	change_column :listings, :price, :decimal, :precision => 8, :scale => 2
  	change_column :listings, :average_price, :decimal, :precision => 8, :scale => 2
  	change_column :bids, :bid_price, :decimal, :precision => 8, :scale => 2
  end
end
