class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :group_discount]

  def index
    @products = Product.all
  end

  def presale_sheet
    @products = Product.all
    @and_2lt_ret = Product.where(code: ["A01", "A02"])
    @and_25lt_des = Product.where(code: "A03")
    @vital_16lt = Product.where(code: "A01")
    @ccu_3lt = Product.where(code: "A02")
  end

  def set_price
    @product_info = {id: @product.id, standard_price: @product.standard_price, extra_tax: @product.extra_tax, cost: @product.cost, units: @product.units, stock: @product.stock}
    respond_to do |format|
      format.html
      format.json {render json: @product_info}
    end
  end

  def set_group_discount
    @product_id = Product.find(params[:product_id]).group_discounts
  end

  def set_product_stock
    @product_stock = Product.find(params[:product_id]).stock
    respond_to do |format|
      format.json {render json: @product_stock}
    end
  end

  def show
    respond_to do |format|
      format.html {}
      format.js { render json: @product }
    end
  end

  def group_discount
    client = Client.find(params[:client_id])
    discount = @product.group_discounts.find_by(group_id: client&.group_id)&.discount
    render json: {
      standard_price: @product.standard_price.to_f,
      extra_tax: @product.extra_tax.to_f,
      cost: @product.cost.to_f,
      unit: @product.units.to_f,
      stock: @product.stock.to_i,
      discount: discount.to_f
    }
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
        format.html { redirect_to @product, notice: 'Se creó el producto exitosamente' }
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
        format.html { redirect_to @product, notice: 'Se actualizó el producto exitosamente' }
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
      params.require(:product).permit(:code, :cost, :name, :category, :packaging, :format, :description, :unit, :units, :extra_tax, :standard_price, :client_id,
      group_discounts_attributes: [:id, :product_id, :group_id, :discount])
    end
end
