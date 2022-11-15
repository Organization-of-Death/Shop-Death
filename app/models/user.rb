class User < ApplicationRecord
    has_many :Inventory,  :dependent => :destroy
    has_many :Market,  :dependent => :destroy
end
