class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :edit_delivery_info, :update_delivery_info]
  before_action :set_client, only: [:create, :update]

  def order_pack_amount
    @client = params['client_id']
    @order = Order.where(client_id: @client).last
    @order_pack_amount = @order.total_packaging_amount || 0
    respond_to do |format|
      format.html
      format.json {render json: @order_pack_amount}
    end
  end

  def dashboard_clients
    @orders_by_count = Order.select(:client_id).group(:client_id).count
    @orders_by_sum = Order.select(:client_id, :total_amount).group(:client_id).sum(:total_amount)
  end

  def packaging_status
    @clients = []
    Client.all.each do |client|
      total_given = Order.where('total_packaging_amount > ?', 0).where(client_id: client.id).sum(:total_packaging_amount)
      if total_given <= 0
      else
        @clients.push(client)
      end
    end
  end

  def delivery_orders
    respond_to do |format|
      format.html
      format.json { render json: DeliveryOrdersDatatable.new(view_context, { action: params[:action]}) }
      format.xlsx {
        render xlsx: 'delivery_orders', filename: "delivery-orders-#{DateTime.now.to_date}.xlsx"
      }
    end
  end

  def my_detail
    @my_orders = Order.where(user_id: current_user.id).select(:client_id).group(:client_id).count
    @my_amounts = Order.where(user_id: current_user.id).select(:client_id, :total_amount).group(:client_id).sum(:total_amount)
  end

  def today_pending
    @today_orders = Order.where('DATE(date) >= ?', Date.today)
    @today_pending_orders = []
    @today_orders.each do |order|
      @total_order_payed = 0
      @order_payments = Payment.where(order_id: order.id)
      @order_payments.each do |order_payment|
        @total_order_payed += order_payment.amount_payed
      end
      if order.discount_amount.nil?
        disc = 0
      else
        disc = order.discount_amount
      end
      if (order.total_amount - disc) > @total_order_payed
        @today_pending_orders.push(order)
      end
    end
  end

  def search
    if (params[:client_business_name])
      client = Client.find_by(business_name: params[:client_business_name])
      @orders = client&.orders
    elsif params[:user_name]
      user = User.find_by(name: params[:user_name])
      @orders = user&.orders
    elsif params[:order_id]
      @orders = Order.find_by(params[:id])
    end
  end

  def my_order
    @orders = Order.where(user: current_user).where('DATE(date) >= ?', Date.today).order(created_at: :desc)
  end

  def index
    @orders = Order.order('created_at DESC')
    respond_to do |format|
      format.html
      format.json { render json: OrdersDatatable.new(view_context, { action: params[:action]}) }
      format.xlsx {
        render xlsx: "index", filename: "orders-#{DateTime.now.to_date}.xlsx"
      }
    end
  end

  def loading_sheets
    @orders = Order.where('DATE(date) >= ?', Date.today).where.not(delivery_method_id: nil)
    @ids_deliveries = Order.where('DATE(date) >= ?', Date.today).where.not(delivery_method_id: nil).pluck(:delivery_method_id)
    names = []
    @product_quantity = @ids_deliveries.each do |elem|
      this_delivery = DeliveryMethod.where(id: elem).map(&:vehicle_plate)
      @orders.each do |order|
        @id_quantity = order.add_products.pluck(:product_id, :quantity)
        @name_quantity = []
        @id_quantity.each do |elem|
          name = Product.where(id: elem[0]).select(:code).first.code
          @name_quantity.push([name, elem[1]])
        end
      end
      return @name_quantity    
    end
    respond_to do |format|
      format.html
      format.xlsx {
        render xlsx: "loading_sheets", filename: "Hoja de carga-#{DateTime.now.to_date}.xlsx"
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

  def create_dte
    @lioren_service = LiorenService.new(@order)
    @lioren_service.post_dte
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = @client.user_id
    respond_to do |format|
      if @order.save
        @order.add_products.each do |add_product|
          product = add_product.product
          StockMovement.create(initial_stock: product.stock, product_id: product.id, final_stock: product.stock - add_product.quantity, movement_type: "Creación orden", stock_quantity: add_product.quantity, id_document: @order.id )
          product.stock -= add_product.quantity
          product.save
        end
        format.html { redirect_to @order, notice: 'La orden se creó correctamente' }
        format.json { render :show, status: :created, location: @order }
      else
        flash[:error] = @order.errors.first
        puts @order.errors.first
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_all
    @delivery_methods = DeliveryMethod.where.not(vehicle_plate: nil)
    respond_to do |format|
      format.html
      format.json { render json: AssignDeliveryMethodDatatable.new(view_context, { action: params[:action]}) }
    end
  end

  def update_all
    @orders = []
    order_params[:orders].each do |_k, order|
      @order = Order.find_by(id: order[:id])
      @order.delivery_method_id = order[:delivery_method_id]
      @orders << @order
    end
    @delivery_methods = DeliveryMethod.where.not(vehicle_plate: nil)
    @update_success = Order.transaction do
      @orders.each(&:save)
    end
    if @update_success
      render partial: 'orders_form', status: 200
    else
      render json: { error: 'Error' }, status: 400
    end
  end

  def update
    @order.user_id = @client.user_id
    respond_to do |format|
      if @order.update(order_params)
        #Añadir lógica de eliminación del AddProduct
        order = @order.id.to_s
        previous_products = StockMovement.where(id_document: order, movement_type: ["Creación orden", "Actualización de orden"]).pluck("product_id")
        actual_products = []

        #Agregar lógica del update Stock
        @order.add_products.each do |add_product|
          product = add_product.product
          previous_quantity = StockMovement.where(id_document: order, movement_type: ["Creación orden", "Actualización de orden"], product_id: product.id)
          if previous_quantity == []
            previous_quantity = 0
          else
            previous_quantity = StockMovement.where(id_document: order, movement_type: ["Creación orden", "Actualización de orden"], product_id: product.id).last.stock_quantity
          end
          #Si la diferencia es positiva, quitaron productos de la orden
          dif = previous_quantity - add_product.quantity
          if dif != 0
            StockMovement.create(initial_stock: product.stock, product_id: product.id, final_stock: product.stock + dif, movement_type: "Actualización de orden", stock_quantity: add_product.quantity, id_document: @order.id )
            product.stock += dif
            product.save
          end
          element = product.id.to_s
          actual_products << element
        end

        #Lógica para agregar devolución de stock para productos eliminados
        deleted_products = previous_products.uniq - actual_products.uniq
        deleted_products.each do |deleted_product|
          initial_stock = StockMovement.where(id_document: order, movement_type: ["Creación orden", "Actualización de orden"], product_id: deleted_product).last.final_stock
          final_stock = StockMovement.where(id_document: order, movement_type: ["Creación orden", "Actualización de orden"], product_id: deleted_product).last.initial_stock
          last_mov_stock = final_stock - initial_stock
          if AddProduct.where(order_id: order, product_id: deleted_product).exists?
          else
            product = Product.find(deleted_product)
            StockMovement.create(initial_stock: product.stock, product_id: product.id, final_stock: product.stock + last_mov_stock, movement_type: "Eliminación del producto", id_document: @order.id )
            product.stock += last_mov_stock
            product.save
          end
        end

        format.html { redirect_to @order, notice: 'La orden se actualizó exitosamente.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_delivery_info
  end

  def update_delivery_info
    @order.update(order_params)
  end

  def destroy 
    @user = current_user.name
    @order.destroy
    respond_to do |format|
      @order.add_products.each do |add_product|
        product = add_product.product
        StockMovement.create(initial_stock: product.stock, product_id: product.id, final_stock: product.stock + add_product.quantity, movement_type: "Eliminación de orden", stock_quantity: add_product.quantity, id_document: @order.id )
        product.stock += add_product.quantity
        product.save
      end
      format.html { redirect_to orders_url, notice: 'La orden fue eliminada' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def set_client
      @client = Client.find(order_params[:client_id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:_destroy, :client_id, :user_id, :delivery_method_id, :net_amount, :total_iva, :client_business_name, :user_name, :total_extra_taxes, :total_amount, :total_packaging_amount, :visit_start, :visit_end, :discount_amount, :discount_comment, :create_invoive, :freight, :responsable, :detail, :date,
      add_products_attributes: [:id, :_destroy, :order_id, :product_id, :price, :discount, :quantity, :total_product_amount, :extra_tax, :packaging_amount, :net_product_amount],
      clients_attributes: [:id,:_destroy,  :business_name, :user_id, :rut, :address, :phone_number, :schedule, :special_agreement, :group_id],
      delivery_methods_attributes: [:id, :_destroy, :vehicle_plate, :policy_number, :ensurance_company],
      orders: [:id, :delivery_method_id])
    end
end