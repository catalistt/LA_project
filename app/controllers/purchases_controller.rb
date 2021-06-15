class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  def index
    @purchases = Purchase.all
  end

  def show
  end

  def purchases_numbers
    @purchases_num = Purchase.all.pluck(:invoice_number)
    respond_to do |format|
      format.html
      format.json {render json: @purchases_num}
    end
  end

  def new
    @purchase = Purchase.new
  end

  def edit
  end

  def create
    @purchase = Purchase.new(purchase_params)

    respond_to do |format|
      if @purchase.save
        @purchase.add_items.each do |add_item|
          product = add_item.product
          StockMovement.create(initial_stock: product.stock, product_id: product.id, final_stock: product.stock + add_item.quantity, movement_type: "Compra", stock_quantity: add_item.quantity, id_document: @purchase.id )
          product.stock += add_item.quantity
          product.save
        end
        format.html { redirect_to @purchase, notice: 'Se creó la compra' }
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @purchase.update(purchase_params)

        @purchase.add_items.each do |add_item|
          product = add_item.product
          purchase = @purchase.id.to_s
          previous_quantity = StockMovement.where(id_document: purchase, movement_type: ["Compra", "Actualización de compra"], product_id: product.id).last.stock_quantity
          if previous_quantity == nil
            previous_quantity = 0
          end
          #Si la diferencia es positiva, quitaron productos de la orden
          dif = previous_quantity - add_item.quantity
          StockMovement.create(initial_stock: product.stock, product_id: product.id, final_stock: product.stock - dif, movement_type: "Actualización de compra", stock_quantity: add_item.quantity, id_document: @purchase.id )
          product.stock -= dif
          product.save
        end


        format.html { redirect_to @purchase, notice: 'La compra fue actualizada.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = current_user.name
    respond_to do |format|
      @purchase.add_items.each do |add_item|
        product = add_item.product
        StockMovement.create(initial_stock: product.stock, product_id: product.id, final_stock: product.stock - add_item.quantity, movement_type: "Eliminación de compra", stock_quantity: add_item.quantity, id_document: @purchase.id )
        product.stock -= add_item.quantity
        product.save
      end

      format.html { redirect_to purchases_url, notice: 'Se eliminó la compra' }
      format.json { head :no_content }
    end
    @purchase.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_params
      params.require(:purchase).permit(:_destroy, :supplier_id, :invoice_number, :total_amount,
      add_items_attributes: [:id, :product_id, :purchase_id, :quantity, :total_product_amount, :price, :expiration_date, :second_expiration_date ] )
    end
end
