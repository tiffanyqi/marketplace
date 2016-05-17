class RenameUserListingColumn < ActiveRecord::Migration
  def change
  	rename_column :listings, :user, :user_id
  	change_column :listings, :user_id, :integer
  end
end
