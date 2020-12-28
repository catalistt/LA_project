class HomeController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
  
    def dashboard
      @orders = Order.all
      @orders_by_sum = Order.select(:client_id, :total_amount).group(:client_id).sum(:total_amount)
      @orders_by_seller = Order.select(:user_id, :total_amount, :created_at).group(:user_id).sum(:total_amount)
      #@orders_by_date = Order.where(:created_at => @selected_start_date..@selected_end_date)
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_home
        @home = Home.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def home_params
        params.require(:home).permit(
        add_orders_attributes: [:client_id, :user_id, :delivery_method_id, :net_amount, :total_iva, :total_extra_taxes, :total_amount, :total_packaging_amount, :visit_start, :visit_end, :discount_amount, :discount_comment, :create_invoive, :responsable])
      end


end