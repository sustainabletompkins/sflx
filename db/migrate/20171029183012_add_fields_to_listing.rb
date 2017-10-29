class AddFieldsToListing < ActiveRecord::Migration
  def change
    add_column :listings, :active, :boolean
    add_column :listings, :user_id, :integer
  end
end
