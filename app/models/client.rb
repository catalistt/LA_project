class Client < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :commune
  belongs_to :city
  has_many :orders

  def to_s
    business_name
  end
end
