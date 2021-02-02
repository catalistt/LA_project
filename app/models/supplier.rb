class Supplier < ApplicationRecord
  has_many :purchases

  def to_s
    name
  end
end

