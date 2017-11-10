class CreateListing < ActiveRecord::Migration[4.2]
  def change
    create_table :listings do |t|
      t.string :title, :null=>:false
      t.string :description, :null=>:false
      t.string :address, :null=>:false
      t.float :latitude
      t.float :longitude
      t.string :email
      t.string :phone
      t.string :website
      t.string :city
      t.integer :zip_code
      t.timestamps
    end
  end
end
