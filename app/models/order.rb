class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :delivery_method

  #Relacion con products y add_products
  has_many :add_products, inverse_of: :order
  has_many :products, through: :add_products
  accepts_nested_attributes_for :add_products, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :products

  #Relacion con payments y payment_methods
  has_many :payments
  has_many :payment_methods, through: :payments
  accepts_nested_attributes_for :payments, allow_destroy: true
  accepts_nested_attributes_for :payment_methods


  #Delegate ayuda a acceder más fácil a atributos de modelos relacionados
  delegate :business_name, to: :client, prefix: true, allow_nil: true 
  delegate :name, to: :user, prefix: true, allow_nil: true 
  delegate :vehicle_plate, to: :delivery_method, prefix: true, allow_nil: true 

  paginates_per 50
  
  before_save do
    total = self.add_products.map { |product| product.quantity * product.total_product_amount }.sum-to_s.to_d
    if total == nil
      total = "0.0".to_d
    end
    self.total_amount = total.to_s.to_d
    self.total_iva = self.total_amount * 0.19
    self.net_amount = total - (total*0.19)
    if self.total_extra_taxes == nil
      self.total_extra_taxes = "0.0".to_d
    else
      self.total_extra_taxes = self.add_products.map { |product| product.quantity * product.extra_tax_id.to_i }.sum.to_s.to_d
    end
  end
end
