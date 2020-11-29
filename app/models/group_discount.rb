class GroupDiscount < ApplicationRecord
  belongs_to :product_id
  belongs_to :group_id
end
