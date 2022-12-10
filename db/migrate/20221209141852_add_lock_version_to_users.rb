class AddLockVersionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :lock_version, :integer, default: 0, null: false
  end
end
