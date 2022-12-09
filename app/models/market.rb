class Market < ApplicationRecord
    belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
    belongs_to :item, :class_name => 'Item',:foreign_key => 'item_id'
    def get_item_name
        Item.find(self.item_id).name
    end

    def get_item_category
        Item.find(self.item_id).category
    end

    def is_enable
        Item.find(self.item_id).enable
    end

    def is_disable
        !self.is_enable
    end


end
