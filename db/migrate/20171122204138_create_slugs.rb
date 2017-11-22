class CreateSlugs < ActiveRecord::Migration[5.1]
  def change
    create_table :slugs do |t|
      add_column :listings, :slug, :string
      add_column :categories, :slug, :string
      add_column :lists, :slug, :string
    end
  end
end
