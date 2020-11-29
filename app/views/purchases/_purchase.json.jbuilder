json.extract! purchase, :id, :product_id_id, :supplier_id_id, :invoice_number, :price, :quantity, :subtotal, :expiration_date, :second_expiration_date, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
