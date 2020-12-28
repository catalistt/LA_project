class Home < ApplicationRecord
  accepts_nested_attributes_for :orders, allow_destroy: true
  
end