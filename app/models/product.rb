class Product < ApplicationRecord
  has_many :group_discounts
  has_many :groups, through: :group_discounts
  has_many :purchases
  has_many :suppliers, through: :purchases
end
