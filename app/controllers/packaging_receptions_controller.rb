class PackagingReceptionsController < InheritedResources::Base

  def packaging_resume
    @packaging_receptions_day = PackagingReception.where(created_at: Time.zone.now.beginning_of_day...zone.now.end_of_day) 
    @packaging_reception_deliveries = @packaging_receptions_day.pluck(:delivery_method_id)
    @turns = PackagingReception.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).pluck(:turn)
    @turns_not_nil = @turns.reject { |n| n == nil }
    @total_turns = @turns_not_nil.count
  end


  private

    def set_packaging_reception
      @packaging_reception = PackagingReception.find(params[:id])
    end

    def packaging_reception_params
      params.require(:packaging_reception).permit(:client_id, :total_box_amount, :delivery_method_id, :total_payed, :turn)
    end

end
