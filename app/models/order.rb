class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :delivery_method, optional: true

  #Relacion con products y add_products
  has_many :add_products, inverse_of: :order
  has_many :products, through: :add_products
  accepts_nested_attributes_for :add_products, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :products

  #Relacion con payments y payment_methods
  has_many :payments
  has_many :payment_methods, through: :payments

  before_save :set_order_amounts

  #Delegate ayuda a acceder más fácil a atributos de modelos relacionados
  delegate :business_name, to: :client, prefix: true, allow_nil: true 
  delegate :name, to: :user, prefix: true, allow_nil: true 
  delegate :vehicle_plate, to: :delivery_method, prefix: true, allow_nil: true

  paginates_per 50

  def set_order_amounts
    add_products.each do |add_product|
      brute_price = add_product.total_product_amount
      net_price = add_product.net_price(brute_price)
      add_product.price = brute_price
      add_product.net_product_amount = net_price
      add_product.extra_tax = net_price * add_product.product_extra_tax
      add_product.discount = add_product.group_discount(client.group_id)
    end
    self.net_amount = add_products.map(&:net_product_amount).reduce(:+)
    self.total_iva = net_amount * 0.19
    self.total_amount = add_products.map(&:total_product_amount).reduce(:+)
    self.total_extra_taxes = add_products.map(&:extra_tax).reduce(:+)
  end
end