class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :delivery_method, optional: true

  #Relacion con products y add_products
  has_many :add_products, inverse_of: :order
  has_many :products, through: :add_products
  accepts_nested_attributes_for :add_products, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :products

  #Relacion con payments y payment_methods
  has_many :payments
  has_many :payment_methods, through: :payments

  #Delegate ayuda a acceder más fácil a atributos de modelos relacionados
  delegate :business_name, to: :client, prefix: true, allow_nil: true 
  delegate :name, to: :user, prefix: true, allow_nil: true 
  delegate :vehicle_plate, to: :delivery_method, prefix: true, allow_nil: true 

  paginates_per 50
  
  before_save do
    #Neto
    self.net_amount = self.add_products.map { |product| product.net_product_amount}.sum.round
    #IVA
    self.total_iva = net_amount * 0.19
    #Total 
    self.total_amount = self.add_products.map { |product| product.total_product_amount}.sum.round
    #Extra taxes
    self.total_extra_taxes = self.add_products.map { |product| product.extra_tax * product.net_product_amount }.sum.round  
    
  end
end