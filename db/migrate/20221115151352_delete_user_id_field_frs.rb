class DeleteUserIdFieldFrs < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :User_id
  end
end
