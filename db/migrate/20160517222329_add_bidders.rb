class AddBidders < ActiveRecord::Migration
  def change
  	add_column :listings, :bidders, :string, array: true, default: []
  end
end
