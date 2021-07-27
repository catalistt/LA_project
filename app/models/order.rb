class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :delivery_method, optional: true
  has_one :commune, through: :client

  #Relacion con products y add_products
  has_many :add_products, inverse_of: :order, dependent: :destroy
  has_many :products, through: :add_products
  accepts_nested_attributes_for :add_products, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :products

  #Relacion con payments y payment_methods
  has_many :payments
  has_many :payment_methods, through: :payments

  before_save :set_order_amounts

  validates :date, presence: true

  #Delegate ayuda a acceder más fácil a atributos de modelos relacionados
  delegate :business_name, to: :client, prefix: :client, allow_nil: true 
  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :vehicle_plate, to: :delivery_method, prefix: true, allow_nil: true
  delegate :name, to: :commune, prefix: true, allow_nil: true

  paginates_per 50

  def set_order_amounts
    add_products.each do |add_product|
      brute_price = add_product.total_product_amount * 0.8
      net_price = add_product.net_price(brute_price)
      packaging_amount = add_product.packaging_amount
      add_product.price = brute_price
      add_product.packaging_amount = packaging_amount
      add_product.net_product_amount = net_price
      add_product.extra_tax = net_price * add_product.product.tax_percentage
      add_product.discount = add_product.group_discount(client.group_id)
    end
    self.total_packaging_amount = add_products.map(&:packaging_amount).reduce(:+)
    self.order_cost = add_products.map(&:product_cost).reduce(:+)
    self.net_amount = add_products.map(&:net_product_amount).reduce(:+)
    self.total_iva = net_amount * 0.19
    total_aux = add_products.map(&:total_product_amount).reduce(:+)
    self.total_amount = total_aux * 0.8
    self.total_extra_taxes = add_products.map(&:extra_tax).reduce(:+)
    self.freight = (self.total_amount * 20)/80
  end

  def total_packaging(packaging_type)
    total = 0
    add_products.each do |add_product|
      if add_product.product.packaging == packaging_type
        total += add_product.quantity
      end
    end
    total
  end

end