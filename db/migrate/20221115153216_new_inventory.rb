class NewInventory < ActiveRecord::Migration[7.0]
  def change
    add_reference :inventories, :buyer, foreign_key: { to_table: :Users }
    add_reference :inventories, :seller, foreign_key: { to_table: :Users }
    add_reference :inventories, :item, foreign_key: { to_table: :items }
  end
end
