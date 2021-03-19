class MoneyMovementsController < InheritedResources::Base

  def square
    @cash_out = MoneyMovement.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, movement_type: 1, payment_method: 1).sum(:amount_payed)
    @cash_in = MoneyMovement.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, movement_type: 0, payment_method: 1).sum(:amount_payed)
  end 

  private

    def money_movement_params
      params.require(:money_movement).permit(:movement_type, :payment_method, :check_date, :received_by, :movement_category, :comment, :amount_payed,
      payment_methods_attributes: [:name, :id])
    end

end
