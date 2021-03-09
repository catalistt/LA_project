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

  def month_names
    ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre','Diciembre']
  end

  def glyphicon(name)
    "<span class='fa fa-#{name}'></span>"
  end

  def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
    end
  end

end
