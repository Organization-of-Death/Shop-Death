class Inventory < ApplicationRecord
  belongs_to :buyer, :class_name => 'User', :foreign_key => 'buyer_id'
  belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
  belongs_to :item, :class_name => 'Item',:foreign_key => 'item_id'

  #user14 item1
end
