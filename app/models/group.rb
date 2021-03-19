class Group < ApplicationRecord
  has_many :clients
  has_many :group_discounts
  has_many :products, through: :group_discounts
end

