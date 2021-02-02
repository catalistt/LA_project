class GroupDiscountsController < ApplicationController
  before_action :set_group_discount, only: [:show, :edit, :update, :destroy]

  def index
    @group_discounts = GroupDiscount.all
  end

  def aut_discount
    @group_discount = GroupDiscount.select(:discount).where(product_id: group_discount_params[:product_id], group_id: group_discount_params[:group_id])
    respond_to do |format|
      format.html
      format.json {render json: @group_discount}
    end
  end

  def show
  end

  def new
    @group_discount = GroupDiscount.new
  end

  def edit
  end

  def create
    @group_discount = GroupDiscount.new(group_discount_params)

    respond_to do |format|
      if @group_discount.save
        format.html { redirect_to @group_discount, notice: 'El descuento fue creado con éxito' }
        format.json { render :show, status: :created, location: @group_discount }
      else
        format.html { render :new }
        format.json { render json: @group_discount.errors, status: :unprocessable_entity }
      end
    end
  end

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
      params.permit(:product_id, :group_id, :discount, 
      product_attributes: [:id, :name],
      group_attributes: [:id, :name])
    end
end
