class Purchase < ApplicationRecord
  has_many :add_items, :inverse_of => :purchase, dependent: :destroy
  has_many :products, through: :add_items
  accepts_nested_attributes_for :add_items, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :products
  belongs_to :supplier

  before_save do
    #Total 
    self.total_amount = self.add_items.map { |item| item.total_product_amount}.sum.round
  end
end
