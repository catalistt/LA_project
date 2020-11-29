class PaymentMethod < ApplicationRecord
  has_many :payments
  has_many :orders, through: :payments
end
