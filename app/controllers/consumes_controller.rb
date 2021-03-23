class ConsumesController < ApplicationController
  before_action :set_consume, only: [:show, :edit, :update, :destroy]

  # GET /consumes
  # GET /consumes.json
  def index
    @consumes = Consume.all
  end

  # GET /consumes/1
  # GET /consumes/1.json
  def show
  end

  # GET /consumes/new
  def new
    @consume = Consume.new
  end

  # GET /consumes/1/edit
  def edit
  end

  # POST /consumes
  # POST /consumes.json
  def create
    @consume = Consume.new(consume_params)

    respond_to do |format|
      if @consume.save
        format.html { redirect_to @consume, notice: 'Consume was successfully created.' }
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
      format.html { redirect_to consumes_url, notice: 'Consume was successfully destroyed.' }
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
