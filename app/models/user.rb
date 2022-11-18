class User < ApplicationRecord
    has_many :Inventory,  foreign_key: :seller_id,  foreign_key: :buyer_id,  :dependent => :destroy
    has_many :Market,  foreign_key: :seller_id,  :dependent => :destroy
end
