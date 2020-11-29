class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :delivery_method
  has_many :add_products
  has_many :products, through: :add_products
  has_many :payments
  has_many :payment_methods, through: :payments
end
