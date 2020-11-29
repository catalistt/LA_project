class Purchase < ApplicationRecord
  belongs_to :product_id
  belongs_to :supplier_id
end
