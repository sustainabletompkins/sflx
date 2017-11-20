class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :zipcode
      t.string :city
      t.string :county
    end
  end
end
