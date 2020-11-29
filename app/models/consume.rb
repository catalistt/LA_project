class Consume < ApplicationRecord
  belongs_to :user_id
  belongs_to :resource_id
end
