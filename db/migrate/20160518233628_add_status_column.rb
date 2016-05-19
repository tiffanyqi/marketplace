class AddStatusColumn < ActiveRecord::Migration
  def change
  	add_column :listings, :accepted, :boolean
  	add_column :bids, :accepted, :boolean 
  end
end
