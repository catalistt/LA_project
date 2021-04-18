class City < ApplicationRecord
  has_many :communes, dependent: :destroy
  validates :code, presence: true
end