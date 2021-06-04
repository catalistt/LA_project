class CashRegistersController < InheritedResources::Base

  def new
    @orders_no_delivery = Order.where('DATE(date) >= ?', Date.today).where(delivery_method_id: nil)
    @orders_delivery = Order.where('DATE(date) >= ?', Date.today).where.not(delivery_method_id: nil)
    @cash_register = CashRegister.new
    
    @cash_out = MoneyMovement.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, movement_type: 1, payment_method: 1).sum(:amount_payed)
    @sale_in_no_delivery = Payment.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, payment_method_id: 1, order_id: @orders_no_delivery).sum(:amount_payed)
    @sale_in_delivery = Payment.: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, payment_method_id: 1, order_id: @orders_delivery).sum(:amount_payed)
    
    @cash_in = MoneyMovement.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, movement_type: 0, payment_method: 1).sum(:amount_payed)
    @last_final_cash = CashRegister.last.final_cash
    @total_in_no_delivery = @sale_in_no_delivery + @cash_in
    @response = {cash_in: @total_in_no_delivery, cash_delivery: @sale_in_delivery, cash_out: @cash_out}
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
