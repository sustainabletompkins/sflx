class AddPlaceIdToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :place_id, :integer
  end
end
