class AddProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order, inverse_of: :add_products
  accepts_nested_attributes_for :product

  delegate :standard_price, to: :product, prefix: :product
  delegate :tax_id, to: :product, prefix: :product

  def self.search(search)
    if search
      Product.where("id LIKE '%#{search}%'")
    end
  end

  def brute_price
    product_standard_price * (quantity || 1)
  end

  def packaging_a(pack_amount)
    pack_amount * (quantity || 1)
  end

  def net_price(brute_amount)
    brute_amount / (1.19 + product.tax.percentage)
  end

  def group_discount(group_id)
    return unless group_id

    discount = product&.group_discounts.find_by(group_id: group_id)&.discount
    discount || 0
  end
end
