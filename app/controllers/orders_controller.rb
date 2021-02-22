class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def dashboard_clients
    @orders_by_count = Order.select(:client_id).group(:client_id).count
    @orders_by_sum = Order.select(:client_id, :total_amount).group(:client_id).sum(:total_amount)
  end

  def my_detail
    @my_orders = Order.where(user_id: current_user.id).select(:client_id).group(:client_id).count
    @my_amounts = Order.where(user_id: current_user.id).select(:client_id, :total_amount).group(:client_id).sum(:total_amount)
  end

  def my_order
    @orders = Order.where(user: current_user)
    @pending_orders = Order.where(visit_end: nil)
    @delivered_orders = Order.where.not(visit_end: nil )
  end

  def index 
    @pending_orders = Order.where(visit_end: nil)
    @delivered_orders = Order.where.not(visit_end: nil)
    @orders = Order.all.order('created_at DESC')
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
    @client = Client.find(order_params[:client_id])
    @order.user_id = @client.user_id
    @order.add_products.each do |add_product|
      brute_price = add_product.brute_price
      net_price = add_product.net_price(brute_price)
      add_product.price = brute_price
      add_product.net_product_amount = net_price
      add_product.extra_tax = net_price * add_product.product_extra_tax
      add_product.discount = add_product.group_discount(@client.group_id)
    end
    @add_products = @order.add_products
    net_amount = @add_products.map(&:net_product_amount).reduce(:+)
    @order.net_amount = net_amount
    @order.total_iva = net_amount * 0.19
    @order.total_amount = @add_products.map(&:total_product_amount).reduce(:+)
    @order.total_extra_taxes = @add_products.map(&:extra_tax).reduce(:+)
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

  def update
    
    respond_to do |format|
      if @order.update(order_params)
        #Añadir lógica de eliminación del AddProduct
        #Agregar lógica del update Stock
        @order.add_products.each do |add_product|
          product = add_product.product
          order = @order.id.to_s
          previous_quantity = StockMovement.where(id_document: order, movement_type: ["Creación orden", "Actualización de orden"], product_id: product.id)
          if previous_quantity == []
            previous_quantity = 0
          else 
            previous_quantity = StockMovement.where(id_document: order, movement_type: ["Creación orden", "Actualización de orden"], product_id: product.id).last.stock_quantity
          end
          #Si la diferencia es positiva, quitaron productos de la orden
          dif = previous_quantity - add_product.quantity
          StockMovement.create(initial_stock: product.stock, product_id: product.id, final_stock: product.stock + dif, movement_type: "Actualización de orden", stock_quantity: add_product.quantity, id_document: @order.id )
          product.stock += dif
          product.save
        end
        format.html { redirect_to @order, notice: 'La orden se actualizó exitosamente.' }
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

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:_destroy, :client_id, :user_id, :delivery_method_id, :net_amount, :total_iva, :total_extra_taxes, :total_amount, :total_packaging_amount, :visit_start, :visit_end, :discount_amount, :discount_comment, :create_invoive, :responsable, :date,
      add_products_attributes: [:id, :_destroy, :order_id, :product_id, :price, :discount, :quantity, :total_product_amount, :extra_tax, :packaging_amount, :net_product_amount],
      clients_attributes: [:id,:_destroy,  :business_name, :user_id, :rut, :address, :phone_number, :schedule, :special_agreement, :group_id],
      delivery_methods_attributes: [:id, :_destroy, :vehicle_plate, :policy_number, :ensurance_company])
    end
end