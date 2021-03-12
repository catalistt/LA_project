class CashRegistersController < InheritedResources::Base

  def new
    @cash_register = CashRegister.new
    @cash_out = MoneyMovement.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, movement_type: 1, payment_method: 1).sum(:amount_payed)
    @cash_in = MoneyMovement.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, movement_type: 0, payment_method: 1).sum(:amount_payed)
  end 


  private

    def cash_register_params
      params.require(:cash_register).permit(:initial_cash, :final_cash)
    end

end
