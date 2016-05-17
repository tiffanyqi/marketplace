class CreateBids < ActiveRecord::Migration
  def change
  	remove_column :listings, :bidders
    create_table :bids do |t|
      t.integer :listing_id
      t.integer :user_id
      t.integer :bid_price
      t.timestamps null: false
    end
  end
end
