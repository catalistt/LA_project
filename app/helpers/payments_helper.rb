module PaymentsHelper

  def amount_unpayed(delivery_id)
    @delivery_orders = number_with_delimiter(Order.where('DATE(date) >= ?', Date.today).where(delivery_method_id: delivery_id).sum(:total_amount).round)
  end

  def delivery_amount_payed(delivery_id)
    @related_orders = Order.where('DATE(date) >= ?', Date.today).where(delivery_method_id: delivery_id)
    @this_delivery_payments = number_with_delimiter(Payment.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, order_id: @related_orders).sum(:amount_payed).round)
  end

  def delivery_cash_payed(delivery_id)
    @related_orders = Order.where('DATE(date) >= ?', Date.today).where(delivery_method_id: delivery_id)
    @this_delivery_payments = number_with_delimiter(Payment.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, order_id: @related_orders, payment_method_id: 1).sum(:amount_payed).round)
  end

  def delivery_check_payed(delivery_id)
    @related_orders = Order.where('DATE(date) >= ?', Date.today).where(delivery_method_id: delivery_id)
    @this_delivery_payments = number_with_delimiter(Payment.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, order_id: @related_orders, payment_method_id: 3).sum(:amount_payed).round)
  end

  def responsables(delivery_id)
    @responsables = Order.where('DATE(date) >= ?', Date.today).where(delivery_method_id: delivery_id).pluck(:responsable).join(', ')
  end

  def pending_by(user_id)
    @orders = Order.where(user_id: user_id)
    @order_payments = Payment.where(order_id: @orders)
    #esta variable guarda el total pagado por los clientes del user_id
    @total_order_payed = 0
    @order_payments.each do |order_payment|
      @total_order_payed += order_payment.amount_payed
    end

    total_sum = 0
    @orders.each do |order|
      if order.discount_amount.nil?
        sum = 0
      else
        sum = order.discount_amount
      end

      if (order.total_amount - sum + order.freight) > @total_order_payed
        total = order.total_amount - sum + order.freight - @total_order_payed
      end
      total_sum += total
    end
    total_sum

  end







end
