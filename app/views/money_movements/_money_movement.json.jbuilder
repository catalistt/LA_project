json.extract! money_movement, :id, :movement_type, :payment_method, :check_date, :received_by, :movement_category, :comment, :created_at, :updated_at
json.url money_movement_url(money_movement, format: :json)
