json.extract! order, :id, :client_id_id, :user_id_id, :delivery_method_id, :net_amount, :total_iva, :total_extra_taxes, :total_amount, :total_packaging_amount, :visit_start, :visit_end, :discount_amount, :discount_comment, :create_invoive, :responsable, :created_at, :updated_at
json.url order_url(order, format: :json)
