json.extract! stock_movement, :id, :product_id_id, :initial_stock, :added, :removed, :final_stock, :created_at, :updated_at
json.url stock_movement_url(stock_movement, format: :json)
