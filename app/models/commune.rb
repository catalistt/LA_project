class Commune < ApplicationRecord
  belongs_to :city
  validates :code, presence: true
end