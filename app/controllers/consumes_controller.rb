class ConsumesController < ApplicationController
  before_action :set_consume, only: [:show, :edit, :update, :destroy]
  before_action :collation, only: [:other_consumes]


  def index
    @consumes = Consume.all.order(created_at: :desc)
  end

  def other_consumes
  end

  def collation
    @users = User.all
    @last_month = (Time.now.beginning_of_month - 1.day).strftime("%m").to_i
    @this_month = (Time.now.beginning_of_month).strftime("%m").to_i
    @next_month = (Time.now.end_of_month + 1.day).strftime("%m").to_i
    @last_month_date = (Time.now.beginning_of_month - 1.day).strftime("%Y-%m-%d").split("-")
    @this_month_date = (Time.now.beginning_of_month).strftime("%Y-%m-%d").split("-")
    @next_month_date = (Time.now.end_of_month + 1.day).strftime("%Y-%m-%d").split("-")

    @last_month_weeks =  Date.new(@last_month_date[0].to_i, @last_month_date[1].to_i, @last_month_date[2].to_i).total_weeks
    @this_month_weeks =  Date.new(@this_month_date[0].to_i, @this_month_date[1].to_i, @this_month_date[2].to_i).total_weeks
    @next_month_weeks =  Date.new(@next_month_date[0].to_i, @next_month_date[1].to_i, @next_month_date[2].to_i).total_weeks

  end

  def show
  end

  def new
    @consume = Consume.new
  end

  def edit
  end

  def create
    @consume = Consume.new(consume_params)

    respond_to do |format|
      if @consume.save
        format.html { redirect_to @consume, notice: 'El consumo fue creado con éxito' }
        format.json { render :show, status: :created, location: @consume }
      else
        format.html { render :new }
        format.json { render json: @consume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consumes/1
  # PATCH/PUT /consumes/1.json
  def update
    respond_to do |format|
      if @consume.update(consume_params)
        format.html { redirect_to @consume, notice: 'Consume was successfully updated.' }
        format.json { render :show, status: :ok, location: @consume }
      else
        format.html { render :edit }
        format.json { render json: @consume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumes/1
  # DELETE /consumes/1.json
  def destroy
    @consume.destroy
    respond_to do |format|
      format.html { redirect_to consumes_url, notice: 'El consumo se eliminó correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consume
      @consume = Consume.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def consume_params
      params.require(:consume).permit(:user_id, :resource_id, :quantity, :category, :total_amount)
    end
end
