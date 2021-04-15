class AddItemsController < InheritedResources::Base
  before_action :set_add_item, only: [:show, :edit, :update, :destroy]

  def index
    @add_items = AddItem.all.order('created_at DESC')

  end

  def new
    @add_item = AddItem.new
  end

  def create
    @add_item = AddItem.new(add_item_params)
    respond_to do |format|
      if @add_item.save
        format.html { redirect_to @add_item, notice: 'Se creó un nuevo registro de compra' }
        format.json { render :show, status: :created, location: @add_item }
      else
        format.html { render :new }
        format.json { render json: @add_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @add_item.update(add_item_params)
        format.html { redirect_to @add_item, notice: 'Se actualizó correctamente' }
        format.json { render :show, status: :ok, location: @add_item }
      else
        format.html { render :edit }
        format.json { render json: @add_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @add_item.destroy
    respond_to do |format|
      format.html { redirect_to add_items_url, notice: 'Add product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_item
      @add_item = AddItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def add_item_params
      params.require(:add_item).permit(:product_id, :quantity, :total_product_amount, :price, :expiration_date, :second_expiration_date, :purchase_id,
      products_attributes: [:product_id, :code, :name, :category, :packaging, :format, :description, :unit, :extra_tax, :standard_price],
      purchases_attributes: [:supplier_id, :invoice_number, :total_amount])
      
    end

end
