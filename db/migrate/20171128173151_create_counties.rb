class CreateCounties < ActiveRecord::Migration[5.1]
  def change
    create_table :counties do |t|
      t.string :county
    end
    add_column :places, :county_id, :integer
    remove_column :places, :county
  end
end
