class Collection < ApplicationRecord
  has_many :product_collections
  has_many :products, through: :product_collections
  has_many :user_collections
  has_many :users, through: :user_collections
end
