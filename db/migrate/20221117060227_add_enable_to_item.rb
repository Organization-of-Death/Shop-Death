class AddEnableToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :enable, :boolean
  end
end
