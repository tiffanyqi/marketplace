class RemoveIndices < ActiveRecord::Migration
  def change
  	remove_index(:bids, :name => 'index_bids_on_listing_id')
  	remove_index(:bids, :name => 'index_bids_on_user_id')
  end
end
