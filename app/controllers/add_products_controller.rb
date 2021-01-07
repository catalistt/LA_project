class AddProductsController < ApplicationController
  before_action :set_add_product, only: [:show, :edit, :update, :destroy]

  def index
    @add_products = AddProduct.all
  end

  def search
    @product = Product.search(params[:search])
    respond_to :js
  end

  def st_price(product_name)
    product_match = Product.where(name: product)
    id_product = product_match.find {|p| p.name == product_name}.id
    AddProduct.default_price(id_product)
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
      params.require(:add_product).permit(:product_id, :order_id, :price, :discount, :quantity, :total_product_amount, :packaging_amount, 
      add_products_attributes: [:product_id, :price, :discount, :quantity, :total_product_amount, :packaging_amount],
      add_clients_attributes: [:client_id, :business_name],
      add_delivery_methods_attributes: [:delivery_method_id, :vehicle_plate, :policy_number, :ensurance_company],
      add_orders_attributes: [:order_id, :client_id, :user_id, :delivery_method_id])
    end
end
