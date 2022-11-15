class NewMarket < ActiveRecord::Migration[7.0]
  def change
    add_reference :markets, :seller, foreign_key: { to_table: :Users }
    add_reference :markets, :item, foreign_key: { to_table: :items }
  end
end
