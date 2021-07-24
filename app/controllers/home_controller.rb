class HomeController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
  
    def dashboard
      @orders = Order.all
      @orders_by_sum = Order.select(:client_id, :total_amount).group(:client_id).sum(:total_amount)
      @orders_by_seller = Order.select(:user_id, :total_amount, :created_at).group(:user_id).sum(:total_amount)
      #@orders_by_date = Order.where(:created_at => @selected_start_date..@selected_end_date)
    end

    def index_communes
      @communes = Commune.all
      respond_to do |format|
        format.xlsx {
          render xlsx: "index_communes", filename: "Comunas-#{DateTime.now.to_date}.xlsx"
        }
      end
    end

    def index_cities
      @cities = City.all
      respond_to do |format|
        format.xlsx {
          render xlsx: "index_cities", filename: "Ciudades-#{DateTime.now.to_date}.xlsx"
        }
      end
    end

    def index_clients
      @clients = Client.all
      respond_to do |format|
        format.xlsx {
          render xlsx: "index_clients", filename: "Clientes-#{DateTime.now.to_date}.xlsx"
        }
      end
    end

    def index_prices
      @products = Product.all
      @group_discounts = GroupDiscount.all
      respond_to do |format|
        format.xlsx {
          render xlsx: "index_prices", filename: "Precios-#{DateTime.now.to_date}.xlsx"
        }
      end
    end



    def index_products
      @products = Product.all
      respond_to do |format|
        format.xlsx {
          render xlsx: "index_products", filename: "Productos-#{DateTime.now.to_date}.xlsx"
        }
      end

    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_home
        @home = Home.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def home_params
        params.require(:home).permit(
        add_orders_attributes: [:client_id, :user_id, :delivery_method_id, :net_amount,:order_cost, :total_iva, :total_extra_taxes, :total_amount, :total_packaging_amount, :visit_start, :visit_end, :discount_amount, :discount_comment, :create_invoive, :responsable])
      end


end