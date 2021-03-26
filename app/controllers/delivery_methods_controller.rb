class DeliveryMethodsController < ApplicationController
  before_action :set_delivery_method, only: [:show, :edit, :update, :destroy]

  # GET /delivery_methods
  # GET /delivery_methods.json
  def index
    @delivery_methods = DeliveryMethod.all
  end

  # GET /delivery_methods/1
  # GET /delivery_methods/1.json
  def show
  end

  # GET /delivery_methods/new
  def new
    @delivery_method = DeliveryMethod.new
  end

  # GET /delivery_methods/1/edit
  def edit
  end

  # POST /delivery_methods
  # POST /delivery_methods.json
  def create
    @delivery_method = DeliveryMethod.new(delivery_method_params)

    respond_to do |format|
      if @delivery_method.save
        format.html { redirect_to @delivery_method, notice: 'Delivery method was successfully created.' }
        format.json { render :show, status: :created, location: @delivery_method }
      else
        format.html { render :new }
        format.json { render json: @delivery_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_methods/1
  # PATCH/PUT /delivery_methods/1.json
  def update
    respond_to do |format|
      if @delivery_method.update(delivery_method_params)
        format.html { redirect_to @delivery_method, notice: 'Delivery method was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery_method }
      else
        format.html { render :edit }
        format.json { render json: @delivery_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_methods/1
  # DELETE /delivery_methods/1.json
  def destroy
    @delivery_method.destroy
    respond_to do |format|
      format.html { redirect_to delivery_methods_url, notice: 'Delivery method was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_delivery_method
    @delivery_method = DeliveryMethod.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def delivery_method_params
    params.require(:delivery_method).permit(:id, :vehicle_plate, :adquisition_date, :policy_number, :ensurance_company,
    orders_attributes: [:id, :delivery_method_id])
  end
end
