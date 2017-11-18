class SwitchColumnNameOnLists < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :approved, :boolean, :default => :true
    remove_column :lists, :active
  end
end
