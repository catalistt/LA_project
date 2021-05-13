class Client < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :commune
  belongs_to :city
  has_many :orders
  has_many :packaging_receptions

  delegate :name, to: :commune, prefix: true, allow_nil: true
  validates :rut, presence: true, uniqueness: true
  validates :business_name, presence: true
  validates :line_of_business, presence: true
  validates :address, presence: true

  def to_s
    business_name
  end
end
