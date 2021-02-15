class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  def index
    @payments = Payment.all.order('created_at DESC')
  end

  def show
  end

  def pending
    @orders = Order.all.order('user_id DESC')
    @sellers = User.with_role(:seller)    
  end

  def set_pendings
    @order = params['order_id']

    #buscar pagos asociados a la orden
    @order_payments = Payment.where(order_id: @order)
    #encontrar costo de la orden
    @order_amount = Order.find(@order).total_amount

    #encontrar cliente asociado
    @client = Order.find(@order).client_id

    #devolver todas las ordenes del cliente y luego encontrar pagos asociados al cliente
    @client_orders = Order.where(client_id: @client)
    @client_payments = Payment.where(order_id: @client_orders)

    @total_order_payed = 0
    @total_order_buyed = 0
    @total_payed = 0
    @total_buyed = 0


    #sumar todos los cobros del cliente
    @client_orders.each do |client_order|
      @total_buyed += client_order.total_amount
    end
    #sumar pagos hechos por el cliente en todas las órdenes
    @client_payments.each do |client_payment|
      @total_payed += client_payment.amount_payed
    end

    #sumar pagos hechos directamente a la orden
    @order_payments.each do |order_payment|
      @total_order_payed += order_payment.amount_payed
    end

    @result = {order_amount: @order_amount, order_payments: @total_order_payed, client_buyed: @total_buyed, client_payments: @total_payed}

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
  