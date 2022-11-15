class D < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :stock
    remove_column :items, :price
  end
end
