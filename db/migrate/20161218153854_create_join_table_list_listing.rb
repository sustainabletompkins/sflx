class CreateJoinTableListListing < ActiveRecord::Migration[4.2]
  def change
    create_join_table :lists, :listings do |t|
      t.index [:list_id, :listing_id]
      t.index [:listing_id, :list_id]
    end
  end
end
