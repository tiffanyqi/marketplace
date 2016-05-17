class AddListingTitlePriceQuantity < ActiveRecord::Migration
  def change
    add_column :listings, :title, :string
    add_column :listings, :average_price, :int
    add_column :listings, :average_quantity, :int
  end
end
