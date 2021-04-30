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

      if (order.total_amount - sum) > @total_order_payed
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



end
