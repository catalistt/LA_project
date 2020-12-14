class Client < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :orders
  accepts_nested_attributes_for :orders, allow_destroy: true

  def to_s
    name
  end
end
