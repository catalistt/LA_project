class Tax < ApplicationRecord
  has_many :products
  validates :code, presence: true, uniqueness: true
end
