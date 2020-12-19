class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :payment_method

 def to_s
    name
 end
end
