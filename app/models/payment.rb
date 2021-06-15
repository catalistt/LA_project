class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :payment_method
  belongs_to :user

end
