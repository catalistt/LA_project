module OrdersHelper
  def details
    ["Sin horario","Prioridad", "Fuera de ruta"]
  end


  def pack_given(client)
    @order_with_pack = Order.where('total_packaging_amount > ?', 0).where(client_id: client).sum(:total_packaging_amount).round || 0
  end

  def pack_payed(client)
    @pack_payments = PackagingReception.where(client: client).sum(:total_box_amount).to_i + PackagingReception.where(client: client).sum(:total_payed).round || 0
  end

  def unpaid_orders
    unpaid_order = []
    Order.all.order(id: :desc).each do |order|
      @order_payments = Payment.where(order_id: order.id)
      @total_order_payed = 0
      @order_payments.each do |order_payment|
        @total_order_payed += order_payment.amount_payed
      end

      if order.discount_amount.nil?
        sum = 0
      else
        sum = order.discount_amount
      end

      if (order.total_amount - sum + order.freight) > @total_order_payed
        unpaid_order.push(order)
      end
    end
    unpaid_order
  end

  def daily_payed_receptions(this_delivery, this_turn)
    @daily_payed_receptions = PackagingReception.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, delivery_method_id: this_delivery, turn: this_turn).sum(:total_payed)
  end

  def daily_received_receptions(this_delivery, this_turn)
    @daily_received_receptions = PackagingReception.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, delivery_method_id: this_delivery, turn: this_turn).sum(:total_box_amount)
  end

  def vehicle_plate(this_delivery)
    @vehicle_plate = DeliveryMethod.find(this_delivery).vehicle_plate
  end

  def monthly_sale(user, month, year, output)
    #Ordenes del mes y año, del usuario especificado
    if Rails.env.production?
      @this_month_orders = Order.where("extract(month from created_at) = ?","0#{month}").where(user_id: user).where("extract(year from created_at) = ?",year)
    else
      @this_month_orders = Order.where("strftime('%m/%Y', created_at) = ?","0#{month}/#{year}").where(user_id: user)
    end 
    
    #Mes pasado
    if month.to_i == 1
      @last_month = 12
    else
      @last_month = month.to_i - 1 
    end

    #Ordenes del mes pasado  
    if Rails.env.production?
      @this_month_orders = Order.where("extract(month from created_at) = ?","0#{@last_month}").where(user_id: user).where("extract(year from created_at) = ?",year)
    else  
      @last_month_orders = Order.where("strftime('%m/%Y', created_at) = ?","0#{@last_month}/#{year}").where(user_id: user)
    end

    #Todas las órdenes del usuario
    @this_user_orders = Order.where(user_id: user)
    
    #Vendido este mes por el usuario (orden y flete)
    @orders_sell = @this_month_orders.sum(:total_amount)
    @orders_freight = @this_month_orders.sum(:freight)
      
    #Descuentos y costo de las órdenes
    @orders_total_discounts = @this_month_orders.sum(:discount_amount) || 0
    @orders_total_costs = @this_month_orders.sum(:order_cost) || 0
    
    #Total, incluyendo flete y descontando dctos.
    @orders_total = @orders_sell - @orders_total_discounts + @orders_freight
    
    #Pagos hechos este mes, para órdenes del usuario
    if Rails.env.production?
      @payments = Payment.where("extract(month from created_at) = ?","0#{month}").where(order_id: @this_user_orders).where("extract(year from created_at) = ?",year)
    else  
      @payments = Payment.where("strftime('%m/%Y', created_at) = ?","0#{month}/#{year}").where(order_id: @this_user_orders)
    end

    @payments_total = @payments.sum(:amount_payed)
    
    #Cálculo de rentabilidad
    @rentability = ((@orders_sell + @orders_freight - @orders_total_costs)/(@orders_sell+@orders_freight))*100
    if @rentability.nan?
      @rentability = 0
    end

    #Cantidad de clientes atendidos
    @clients_served = @this_month_orders.distinct.pluck(:client_id).count 
    #Atendidos mes pasado vs este mes
    @clients_served_last = @last_month_orders.distinct.pluck(:client_id).count

    if @clients_served_last == 0
      @clients_vs = 0
    else
      @clients_vs = (((@clients_served.to_f / @clients_served_last.to_f) -1 ) *100).round
    end
    
    if @clients_vs >  0
      @clients_vs = "+ #{@clients_vs}"
    end


    #Return según lo que se pida
    if output == "payments"
      return number_with_delimiter(@payments_total.round)
    elsif output == "orders"
      return number_with_delimiter(@orders_total.round)
    elsif output == "rentability"
      return @rentability.round(2)
    elsif output == "clients_served"
      return @clients_served
    else
      return @clients_vs
    end
  end

end
