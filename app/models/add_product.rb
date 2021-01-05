class AddProduct < ApplicationRecord
  attr_accessor :product_attributes
  belongs_to :product
  belongs_to :order

  accepts_nested_attributes_for :product, :reject_if => :all_blank
  
end
