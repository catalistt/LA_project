json.extract! product, :id, :code, :name, :type, :packaging, :format, :description, :unit, :extra_tax, :standard_price, :created_at, :updated_at
json.url product_url(product, format: :json)
