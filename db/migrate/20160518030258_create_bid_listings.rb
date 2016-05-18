class CreateBidListings < ActiveRecord::Migration
  def change
    create_join_table :bids, :listings do |t|
      t.integer :bid_id
      t.integer :listing_id
    end
  end
end
