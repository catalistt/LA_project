class PackagingReception < ApplicationRecord
  belongs_to :client
  belongs_to :delivery_method
end
