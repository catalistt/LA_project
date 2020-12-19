class AddProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def default_price(id_product)
    Product.find(id_product).standard_price
  end
end
