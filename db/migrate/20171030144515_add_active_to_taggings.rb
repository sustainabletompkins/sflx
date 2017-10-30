class AddActiveToTaggings < ActiveRecord::Migration
  def change
    add_column :taggings, :active, :boolean, :default => :true
  end
end
