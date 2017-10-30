class CreateTagSuggestions < ActiveRecord::Migration
  def change
    create_table :tag_suggestions do |t|
      t.string :name
      t.belongs_to :user
      t.timestamps
      t.belongs_to :listing
    end
  end
end
