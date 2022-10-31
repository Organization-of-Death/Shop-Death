class User < ApplicationRecord
    has_many :item, dependent: :destroy
end
