class Product < ApplicationRecord
  has_many :group_discounts, dependent: :destroy
  has_many :groups, through: :group_discounts, dependent: :destroy
  belongs_to :tax, optional: true

  #Relación con order y add_products
  has_many :add_products, dependent: :destroy
  has_many :orders, through: :add_products, dependent: :destroy

  #Relación con purchase y add_items
  has_many :add_items, dependent: :destroy
  has_many :purchases, through: :add_items, dependent: :destroy

  has_many :stock_movements
  has_many :adquisition_costs, dependent: :destroy
  enum category: [:soda, :beer, :wine, :snack, :water, :energetic, :isotonic, :nectar, :service, :promotion, :tea]

  validates :code, presence: true, format: { with: /\A[0-9a-zA-Z]+\z/,
    message: 'Sólo se permite letras y números' }
  validates :name, presence: true
  validates :standard_price, presence: true

  delegate :code, to: :tax, prefix: true, allow_nil: true

  def tax_percentage
    tax&.percentage || 0
  end
end
