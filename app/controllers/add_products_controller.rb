class AddProductsController < ApplicationController
  before_action :set_add_product, only: [:show, :edit, :update, :destroy]

  def index
    @add_products = AddProduct.all

  end

  def print_detail
    @orders = Order.where('DATE(date) >= ?', Date.today).where.not(delivery_method_id: nil)
    @orders_products = AddProduct.select("orders.*").includes(:order).joins(:order).where(order_id: @orders)
    @today_rounds = Order.where('DATE(date) >= ?', Date.today).where.not(delivery_method_id: nil).pluck(:round).uniq.sort
    @ids_deliveries = Order.where('DATE(date) >= ?', Date.today).where.not(delivery_method_id: nil).pluck(:delivery_method_id)
    @deliveries = DeliveryMethod.where(id: @ids_deliveries).map(&:vehicle_plate)


    respond_to do |format|
      format.html
      format.xlsx {
        render xlsx: "add_product_detail", filename: "Detalle-#{DateTime.now.to_date}.xlsx"
      }
    end

  end


  def search
    @product = Product.search(params[:search])
    respond_to :js
  end

  def new
    @add_product = AddProduct.new
  end

  def create
    @add_product = AddProduct.new(add_product_params)
    respond_to do |format|
      if @add_product.save
        format.html { redirect_to @add_product, notice: 'Add product was successfully created.' }
        format.json { render :show, status: :created, location: @add_product }
      else
        format.html { render :new }
        format.json { render json: @add_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @add_product.update(add_product_params)
        format.html { redirect_to @add_product, notice: 'Add product was successfully updated.' }
        format.json { render :show, status: :ok, location: @add_product }
      else
        format.html { render :edit }
        format.json { render json: @add_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @add_product.destroy
    respond_to do |format|
      format.html { redirect_to add_products_url, notice: 'Add product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_product
      @add_product = AddProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def add_product_params
      params.require(:add_product).permit(:product_id, :order_id, :price, :discount, :quantity, :product_cost, :total_product_amount, :packaging_amount, 
      add_products_attributes: [:product_id, :price, :discount, :quantity, :total_product_amount, :packaging_amount],
      add_items_attributes: [product_id, :quantity, :total_product_amount, :price, :expiration_date, :second_expiration_date, :purchase_id],
      add_clients_attributes: [:client_id, :business_name],
      add_delivery_methods_attributes: [:delivery_method_id, :vehicle_plate, :policy_number, :ensurance_company],
      add_orders_attributes: [:order_id, :order_cost, :client_id, :user_id, :delivery_method_id, :round])
    end
end
