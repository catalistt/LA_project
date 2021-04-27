class PackagingReceptionsController < InheritedResources::Base


  private

    def packaging_reception_params
      params.require(:packaging_reception).permit(:client_id, :total_box_amount, :delivery_method_id, :total_payed)
    end

end
