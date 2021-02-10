class StockMovementsController < ApplicationController
  before_action :set_stock_movement, only: [:show, :edit, :update, :destroy]

  # GET /stock_movements
  # GET /stock_movements.json
  def index
    @stock_movements = StockMovement.all.order(created_at: :desc)
  end

  # GET /stock_movements/1
  # GET /stock_movements/1.json
  def show
  end

  # GET /stock_movements/new
  def new
    @stock_movement = StockMovement.new
  end

  # GET /stock_movements/1/edit
  def edit
  end

  def create
    @stock_movement = StockMovement.new(stock_movement_params)
    @product = @stock_movement.product
    @product.stock = @stock_movement.final_stock
    respond_to do |format|
      if @stock_movement.save
        @product.save
        format.html { redirect_to @stock_movement, notice: 'Se creó correctamente el movimiento de stock' }
        format.json { render :index, status: :created, location: @stock_movement }
      else
        format.html { render :new }
        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @stock_movement.update(stock_movement_params)
        format.html { redirect_to @stock_movement, notice: 'Stock movement was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_movement }
      else
        format.html { render :edit }
        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_movements/1
  # DELETE /stock_movements/1.json
  def destroy
    @stock_movement.destroy
    respond_to do |format|
      format.html { redirect_to stock_movements_url, notice: 'Stock movement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_movement
      @stock_movement = StockMovement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_movement_params
      params.require(:stock_movement).permit(:product_id, :initial_stock, :movement_type, :stock_quantity, :final_stock, :id_document)
    end
end
