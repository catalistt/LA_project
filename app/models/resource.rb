class Resource < ApplicationRecord
  has_many :consumes
  has_many :users, through: :consume
end
