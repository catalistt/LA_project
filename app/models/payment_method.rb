class PaymentMethod < ApplicationRecord
  has_many :payments
  has_many :orders, through: :payments
  
  def to_s
    name
  end
end
