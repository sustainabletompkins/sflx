class AddCountyToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :county, :string
  end
end
