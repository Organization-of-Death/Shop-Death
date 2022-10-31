class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :User, null: false, foreign_key: true
      t.string :Item
      t.integer :price
      t.string :name
      t.string :seller

      t.timestamps
    end
  end
end
