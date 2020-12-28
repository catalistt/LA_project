class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :delivery_method
  has_many :add_products
  has_many :products, through: :add_products
  has_many :payments
  has_many :payment_methods, through: :payments
  accepts_nested_attributes_for :add_products, allow_destroy: true
  accepts_nested_attributes_for :payments, allow_destroy: true
  delegate :business_name, to: :client, prefix: true, allow_nil: true 
  delegate :name, to: :user, prefix: true, allow_nil: true 
  delegate :vehicle_plate, to: :delivery_method, prefix: true, allow_nil: true 

  paginates_per 50
end
