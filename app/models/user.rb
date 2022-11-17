class User < ApplicationRecord
    #has_many :Inventory,  :dependent => :destroy
    has_many :Market,  foreign_key: :seller_id,  :dependent => :destroy
end
