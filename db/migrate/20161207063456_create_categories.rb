class CreateCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :categories do |t|
      t.string :name, :required => :true
      t.string :description, :required => :true
    end
  end
end
