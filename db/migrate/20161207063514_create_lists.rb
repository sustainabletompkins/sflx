class CreateLists < ActiveRecord::Migration[4.2]
  def change
    create_table :lists do |t|
      t.string :name, :required => :true
      t.string :description, :required => :true
      t.belongs_to :category
    end
  end
end
