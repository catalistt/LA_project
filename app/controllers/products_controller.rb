class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]


  def index
    @products = Product.all
  end

  def set_price
    @product = Product.find(params[:product_id])
    @product_prices = {Ruta: @product.standard_price, Precio_1: @product.cost * 0.055 + @product.cost, Precio_2: @product.cost * 0.075 + @product.cost, Precio_3: @product.cost * 0.095 + @product.cost, Precio_4: @product.cost * 0.115 + @product.cost, Precio_5: @product.cost * 0.135 + @product.cost}
    @product_info = {standard_price: @product.standard_price, extra_tax: @product.extra_tax, cost: @product_prices, unit: @product.units}
    respond_to do |format|
      format.html
      format.json {render json: @product_info}
    end
  end

  def set_group_discount
    @product_id = Product.find(params[:product_id]).group_discounts
  end

  def show
  end


  def new
    @product = Product.new
  end

  def edit
  end


  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'El producto fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:code, :name, :category, :packaging, :format, :description, :unit, :extra_tax, :standard_price,
      group_discounts_attributes: [:id, :product_id, :group_id, :discount])
    end
end
