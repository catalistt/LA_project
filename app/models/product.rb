class Product < ApplicationRecord
  has_many :group_discounts, dependent: :destroy
  has_many :groups, through: :group_discounts, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :suppliers, through: :purchases, dependent: :destroy

  #Relación con order y add_products
  has_many :add_products, dependent: :destroy
  has_many :orders, through: :add_products, dependent: :destroy

  has_many :stock_movements, dependent: :destroy
  has_many :adquisition_costs, dependent: :destroy
  enum category: [:soda, :beer, :wine, :snack, :water]

end
