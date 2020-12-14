class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @pending_orders = Order.where(visit_end: nil)
    @delivered_orders = Order.where.not(visit_end: nil)
    @orders = Order.all
  end

  def dashboard_clients
    @orders_by_count = Order.select(:client_id).group(:client_id).count
    @orders_by_sum = Order.select(:client_id, :total_amount).group(:client_id).sum(:total_amount)
  end

  def my_order
    @orders = Order.where(user: current_user)
    @pending_orders = Order.where(visit_end: nil)
    @delivered_orders = Order.where.not(visit_end: nil )
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'La orden se acutalizó exitosamente.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:client_id, :user_id, :delivery_method_id, :net_amount, :total_iva, :total_extra_taxes, :total_amount, :total_packaging_amount, :visit_start, :visit_end, :discount_amount, :discount_comment, :create_invoive, :responsable,
      add_products_attributes: [:product_id, :price, :discount, :quantity],
      add_clients_attributes: [:client_id, :business_name],
      add_delivery_methods_attributes: [:delivery_method_id, :vehicle_plate, :policy_number, :ensurance_company])
    end
end
