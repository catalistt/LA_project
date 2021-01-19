class AddProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order, inverse_of: :add_products
  accepts_nested_attributes_for :product

  def self.search(search)
    if search
          Product.where("id LIKE '%#{search}%'")
    end
  end
end
