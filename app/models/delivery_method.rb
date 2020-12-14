class DeliveryMethod < ApplicationRecord
  has_many :orders
  accepts_nested_attributes_for :orders, allow_destroy: true
end
