class Client < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :orders

  def to_s
    business_name
  end
end
