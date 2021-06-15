class PackagingReception < ApplicationRecord
  belongs_to :client
  belongs_to :delivery_method
  validates :turn, presence: true
end
