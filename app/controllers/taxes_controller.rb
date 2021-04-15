class TaxesController < InheritedResources::Base

  private

    def tax_params
      params.require(:tax).permit(:name, :percentage, :code)
    end

end
