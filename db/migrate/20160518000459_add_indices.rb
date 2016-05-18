class AddIndices < ActiveRecord::Migration
  def change
  	add_index :bids, :listing_id
    add_index :bids, :user_id
    add_index :listings, :user_id

  end
end
