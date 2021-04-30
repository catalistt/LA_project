class AdquisitionCostsController < ApplicationController
  before_action :set_adquisition_cost, only: [:show, :edit, :update, :destroy]

  # GET /adquisition_costs
  # GET /adquisition_costs.json
  def index
    @adquisition_costs = AdquisitionCost.all
  end

  # GET /adquisition_costs/1
  # GET /adquisition_costs/1.json
  def show
    @product = @adquisition_cost.product_id
    @product_price = Product.find(@product).standard_price
  end

  # GET /adquisition_costs/new
  def new
    @adquisition_cost = AdquisitionCost.new
  end

  # GET /adquisition_costs/1/edit
  def edit
  end

  # POST /adquisition_costs
  # POST /adquisition_costs.json
  def create
    @adquisition_cost = AdquisitionCost.new(adquisition_cost_params)
    @product_id = @adquisition_cost.product_id
    @product = Product.find(@product_id)
    @standard_price = @product.standard_price
    @actual_cost = @product.cost
    @percentage = (@standard_price - @actual_cost) / @actual_cost
    @new_standard_price = (@adquisition_cost.cost * @percentage) + @adquisition_cost.cost

    respond_to do |format|
      if @adquisition_cost.save
        @product.update(cost: @adquisition_cost.cost, standard_price: @new_standard_price)
        format.html { redirect_to @adquisition_cost, notice: 'Adquisition cost was successfully created.' }
        format.json { render :show, status: :created, location: @adquisition_cost }
      else
        format.html { render :new }
        format.json { render json: @adquisition_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adquisition_costs/1
  # PATCH/PUT /adquisition_costs/1.json
  def update
    respond_to do |format|
      if @adquisition_cost.update(adquisition_cost_params)
        format.html { redirect_to @adquisition_cost, notice: 'Adquisition cost was successfully updated.' }
        format.json { render :show, status: :ok, location: @adquisition_cost }
      else
        format.html { render :edit }
        format.json { render json: @adquisition_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adquisition_costs/1
  # DELETE /adquisition_costs/1.json
  def destroy
    @adquisition_cost.destroy
    respond_to do |format|
      format.html { redirect_to adquisition_costs_url, notice: 'Adquisition cost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adquisition_cost
      @adquisition_cost = AdquisitionCost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def adquisition_cost_params
      params.require(:adquisition_cost).permit(:product_id, :cost)
    end
end
