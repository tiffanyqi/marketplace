class ChangeColumnNamePriceQuantityNames < ActiveRecord::Migration
  def change
  	rename_column :listings, :average_price, :price
  	rename_column :listings, :average_quantity, :bid_quantity
  end
end
