class PaymentMethod < ApplicationRecord
  has_many :payments
  has_many :orders, through: :payments
  accepts_nested_attributes_for :orders, allow_destroy: true
  accepts_nested_attributes_for :payments, allow_destroy: true
  def to_s
    name
  end
end
