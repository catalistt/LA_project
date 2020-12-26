class HomeController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
  
    def dashboard
      @order = Order.all
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_home
        @home = Payment.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def home_params
        params.require(:home).permit(
        orders_attributes(:client_id, :user_id, :delivery_method_id, :net_amount, :total_iva, :total_extra_taxes, :total_amount, :total_packaging_amount, :visit_start, :visit_end, :discount_amount, :discount_comment, :create_invoive, :responsable))
      end


end