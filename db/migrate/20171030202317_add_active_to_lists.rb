class AddActiveToLists < ActiveRecord::Migration[4.2]
  def change
    add_column :lists, :active, :boolean, :default => :true
  end
end
