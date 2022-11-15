class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.decimal :price
      t.integer :qty

      t.timestamps
    end
  end
end
