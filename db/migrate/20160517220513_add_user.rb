class AddUser < ActiveRecord::Migration
  def change
  	add_column :listings, :user, :string
  end
end
