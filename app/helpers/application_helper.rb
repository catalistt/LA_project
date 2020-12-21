module ApplicationHelper

  def afps
    ["AFP Capital","AFP Cuprum","AFP Habitat","AFP Modelo","AFP Planvital","AFP Provida"]
  end

  def health_system_name
    ["Isapre Banmédica", "Isapre Colmena", "Isapre Consalud", "Isapre Cruzblanca", "Isapre nueva masvida", "Isapre vida tres", "Fonasa A", "Fonasa B", "Fonasa C", "Fonasa D"]
  end

  def order_with_name
    orders_name = []
    Order.all.each do |order|
      element = ["#{order.id} - #{order.client}"]
      orders_name.push(element)
    end
    return orders_name
  end

  def order_status
    ["Pagada", "Pago incompleto", "Pendiente"]
  end

  def payment_name
    payments_name = []
    PaymentMethod.all.each do |payment|
      element = ["#{payment.id} - #{payment.name}"]
      payments_name.push(element)
    end
    return payments_name
  end

  def product_with_code

    products_name = []
    Product.all.each do |product|
      element = ["#{product.code} - #{product.name}"]
      products_name.push(element)
    end
    return products_name
  end

end
