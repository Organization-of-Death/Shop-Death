class Market < ApplicationRecord
    belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
    belongs_to :item, :class_name => 'Item',:foreign_key => 'item_id'
    
end
