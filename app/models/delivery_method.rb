class DeliveryMethod < ApplicationRecord
  has_many :orders
  has_many :packaging_receptions
  accepts_nested_attributes_for :orders

  validates :vehicle_plate, presence: true
  before_save :sanitize_plate

  def sanitize_plate
    vehicle_plate.uppercase
  end

  scope :available, -> { where.not(vehicle_plate: [nil, '']) }
end
