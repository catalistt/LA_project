class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def dashboard_clients
    @orders_by_count = Order.select(:client_id).group(:client_id).count
    @orders_by_sum = Order.select(:client_id, :total_amount).group(:client_id).sum(:total_amount)
  end

  def my_order
    @orders = Order.where(user: current_user)
    @pending_orders = Order.where(visit_end: nil)
    @delivered_orders = Order.where.not(visit_end: nil )
  end

  def index 
    @pending_orders = Order.where(visit_end: nil)
    @delivered_orders = Order.where.not(visit_end: nil)
    @orders = Order.all
    respond_to do |format|
      format.html
      format.xlsx {
        render xlsx: "index", filename: "orders-#{DateTime.now.to_date}.xlsx"
      }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render  :pdf => "Orden_#{@order.id}", :template => 'orders/_order_pdf.erb',
        layout: 'pdf_layout.html.erb', 
        disposition: 'inline',
        viewport_size: "1280x1024",
        encoding:"UTF-8",
        show_as_html: params[:debug].present?
      end
    end 
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = Client.find(order_params[:client_id]).user_id
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'La orden se creó correctamente' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy 
    @user = current_user.name
    @order.destroy
    respond_to do |format|
      UserNotifierMailer.send_deleted_order(@order).deliver
      format.html { redirect_to orders_url, notice: 'La orden fue eliminada' }
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
      params.require(:order).permit(:client_id, :user_id, :delivery_method_id, :net_amount, :total_iva, :total_extra_taxes, :total_amount, :total_packaging_amount, :visit_start, :visit_end, :discount_amount, :discount_comment, :create_invoive, :responsable, :date,
      add_products_attributes: [:id, :order_id, :product_id, :price, :discount, :quantity, :total_product_amount, :extra_tax_id, :packaging_amount],
      add_clients_attributes: [:id, :business_name, :user_id, :rut, :address, :phone_number, :schedule, :special_agreeement, :group_id],
      add_delivery_methods_attributes: [:id, :vehicle_plate, :policy_number, :ensurance_company],
      add_add_products_attributes: [:id, :order_id, :product_id, :price, :discount, :quantity, :total_product_amount, :extra_tax_id, :packaging_amount])
    end
end
