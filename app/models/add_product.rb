class AddProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order, inverse_of: :add_products

  accepts_nested_attributes_for :product

  def self.search(search)
    if search
          Product.where("id LIKE '%#{search}%'")
    end
  end

  before_save do
    extra_tax = Product.find(product_id).extra_tax
    net_product_amount = total_product_amount/(1+0.19+extra_tax)
    self.net_product_amount = net_product_amount
    self.extra_tax = net_product_amount * extra_tax
  end
end
