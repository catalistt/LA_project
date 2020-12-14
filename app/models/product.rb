class Product < ApplicationRecord
  has_many :group_discounts
  has_many :groups, through: :group_discounts
  has_many :purchases
  has_many :suppliers, through: :purchases
  has_many :add_products
  has_many :orders, through: :add_products
  has_many :stock_movements
  has_many :adquisition_costs
  accepts_nested_attributes_for :add_products, allow_destroy: true
end
