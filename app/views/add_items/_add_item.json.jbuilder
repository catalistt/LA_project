json.extract! add_item, :id, :product_id, :quantity, :total_product_amount, :price, :expiration_date, :second_expiration_date, :purchase_id, :created_at, :updated_at
json.url add_item_url(add_item, format: :json)
