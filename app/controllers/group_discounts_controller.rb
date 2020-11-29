class GroupDiscountsController < ApplicationController
  before_action :set_group_discount, only: [:show, :edit, :update, :destroy]

  # GET /group_discounts
  # GET /group_discounts.json
  def index
    @group_discounts = GroupDiscount.all
  end

  # GET /group_discounts/1
  # GET /group_discounts/1.json
  def show
  end

  # GET /group_discounts/new
  def new
    @group_discount = GroupDiscount.new
  end

  # GET /group_discounts/1/edit
  def edit
  end

  # POST /group_discounts
  # POST /group_discounts.json
  def create
    @group_discount = GroupDiscount.new(group_discount_params)

    respond_to do |format|
      if @group_discount.save
        format.html { redirect_to @group_discount, notice: 'Group discount was successfully created.' }
        format.json { render :show, status: :created, location: @group_discount }
      else
        format.html { render :new }
        format.json { render json: @group_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_discounts/1
  # PATCH/PUT /group_discounts/1.json
  def update
    respond_to do |format|
      if @group_discount.update(group_discount_params)
        format.html { redirect_to @group_discount, notice: 'Group discount was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_discount }
      else
        format.html { render :edit }
        format.json { render json: @group_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_discounts/1
  # DELETE /group_discounts/1.json
  def destroy
    @group_discount.destroy
    respond_to do |format|
      format.html { redirect_to group_discounts_url, notice: 'Group discount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_discount
      @group_discount = GroupDiscount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_discount_params
      params.require(:group_discount).permit(:product_id_id, :group_id_id, :discount)
    end
end
