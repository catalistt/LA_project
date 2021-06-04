class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  def index
    @payments = Payment.all.order('created_at DESC')
  end

  def show
  end

  def delivery_payments
    @delivery_payments = Hash.new
    @ids_deliveries = Order.where('DATE(date) >= ?', Date.today).pluck(:delivery_method_id)
    @deliveries_used = DeliveryMethod.where(id: @ids_deliveries)
    @delivery_method = DeliveryMethod.all
    @delivery_method.each do |delivery|
      @related_orders = Order.where('DATE(date) >= ?', Date.today).where(delivery_method_id: delivery.id).pluck(:id)
      @this_delivery_payments = Payment.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, order_id: @related_orders).sum(:amount_payed)
      @delivery_payments["#{delivery.id}"] = "#{@this_delivery_payments}"
    end

  end

  def pending
    @orders = Order.all.order('id DESC')
    @gerencia = User.where(role: "admin")
    @p_gerencia = Order.where(user_id: @gerencia)
    @antonio = User.find(3)
    @p_antonio = Order.where(user_id: @antonio)
    @brian = User.find(2)
    @p_brian = Order.where(user_id: @brian)
    @ronald = User.find(5)
    @p_ronald = Order.where(user_id: @ronald)
    @luis = User.find(4)
    @p_luis = Order.where(user_id: @luis)
  end

  def today_pending
    @today_orders = Order.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @order_payments= Payment.where(order_id: @today_orders)
    @orders = []
    sum = 0
    @today_orders.each do |order|
      @total_order_payed = Payment.where(order_id: order.id).pluck(:amount_payed)
      if @total_order_payed[0].nil?
        @orders.push(order.id)
      end
    end
    @orders_unpayed = Order.where(id: @orders)
  end

  def set_pendings
    @order = params['order_id']

    #buscar pagos asociados a la orden
    @order_payments = Payment.where(order_id: @order)
    #encontrar costo de la orden
    @aux_amount_1 = Order.find(@order).total_amount
    @aux_amount_2 = Order.find(@order).freight || 0
    @aux_amount_total = @aux_amount_1 + @aux_amount_2
    @order_amount = @aux_amount_total

    #encontrar dcto de la orden
    @disc = Order.find(@order).discount_amount
    if @disc.nil?
      @disc_amount = 0
    else
      @disc_amount = @disc
    end

    #encontrar cliente asociado
    @client = Order.find(@order).client_id

    #devolver todas las ordenes del cliente y luego encontrar pagos asociados al cliente
    @client_orders = Order.where(client_id: @client)
    @client_payments = Payment.where(order_id: @client_orders)

    @total_order_payed = 0
    @total_order_buyed = 0
    @total_payed = 0
    @total_buyed = 0
    @total_discount = 0


    #sumar todos los cobros del cliente
    @client_orders.each do |client_order|
      @aux_f = client_order.freight || 0
      @aux_a = client_order.total_amount
      @aux_t = @aux_f + @aux_a
      @total_buyed += @aux_t
    end
    #sumar pagos hechos por el cliente en todas las órdenes
    @client_payments.each do |client_payment|
      @total_payed += client_payment.amount_payed
    end

    #sumar dctos hechos al cliente en todas las órdenes
    @client_orders.each do |client_order|
      if client_order.discount_amount.nil?
        sum = 0
      else
        sum = client_order.discount_amount
      end
      @total_discount += sum
    end

    #sumar pagos hechos directamente a la orden
    @order_payments.each do |order_payment|
      @total_order_payed += order_payment.amount_payed
    end

    @result = {order_discount: @disc_amount, client_discounts: @total_discount, order_amount: @order_amount, order_payments: @total_order_payed, client_buyed: @total_buyed, client_payments: @total_payed}

    respond_to do |format|
      format.html
      format.json {render json: @result}
    end
    
  end

  def new
    @payment = Payment.new
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Se registró el pago correctamente.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Se actualizó el pago correctamente' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'El pago fue eliminado correctamente' }
      format.json { head :no_content }
    end
  end

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:order_id, :payment_method_id, :amount_payed, :check_date, :status,
      orders_attributes: [:id, :client_id, :user_id, :delivery_method_id, :net_amount, :total_iva, :total_extra_taxes, :total_amount, :total_packaging_amount, :visit_start, :visit_end, :discount_amount, :discount_comment, :create_invoive, :responsable],
      payment_methods_attributes: [:name])
    end
end
  