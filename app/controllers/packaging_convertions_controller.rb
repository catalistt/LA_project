class PackagingConvertionsController < InheritedResources::Base

  def pack_info
    @packaging = params['packaging_convertion_id']
    @amount = PackagingConvertion.find(@packaging).cost

    respond_to do |format|
      format.html
      format.json {render json: @amount}
    end

  end


  private

    def set_packaging_convertion
      @packaging_convertion = PackagingConvertion.find(params[:id])
    end

    def packaging_convertion_params
      params.require(:packaging_convertion).permit(:id,:name, :cost, :supplier_id)
    end

end
