class Item < ApplicationRecord
  has_many :Inventory,  :dependent => :destroy
  has_many :Market,  :dependent => :destroy
  has_one_attached :picture
end
