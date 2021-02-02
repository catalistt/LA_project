class AddItem < ApplicationRecord
  belongs_to :product
  belongs_to :purchase, inverse_of: :add_items
  accepts_nested_attributes_for :product
end
