json.extract! product, :id, :cod, :name, :type, :packaging, :format, :description, :unit, :extra_tax, :stardard_price, :created_at, :updated_at
json.url product_url(product, format: :json)
