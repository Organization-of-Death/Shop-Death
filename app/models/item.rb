class Item < ApplicationRecord
  has_many :Inventory,  :dependent => :destroy
  has_many :Market,  :dependent => :destroy
  has_one_attached :picture do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
end
