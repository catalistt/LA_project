class CashRegistersController < InheritedResources::Base

  def new
    @cash_register = CashRegister.new
    @cash_out = MoneyMovement.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, movement_type: 1, payment_method: 1).sum(:amount_payed)
    @sale_in = Payment.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, payment_method_id: 1).sum(:amount_payed)
    @cash_in = MoneyMovement.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, movement_type: 0, payment_method: 1).sum(:amount_payed)
    @last_final_cash = CashRegister.last.final_cash
    @total_in = @sale_in + @cash_in
    @response = {cash_in: @total_in, cash_out: @cash_out}
    respond_to do |format|
      format.html
      format.json {render json: @response}
    end
  end 


  private

    def cash_register_params
      params.require(:cash_register).permit(:initial_cash, :final_cash)
    end

end
