class DeliveryOrdersDatatable
  delegate :params, :h, :link_to, :number_to_currency, :content_tag, :raw, to: :@view
  include Rails.application.routes.url_helpers

  def initialize(view, options = {})
    @view = view
    @action = options[:action]
  end

  def as_json(options = {})
    {
      sEcho:                params[:sEcho].to_i,
      iTotalRecords:        Order.count,
      iTotalDisplayRecords: orders.total_entries,
      aaData:               data
    }
  end

  private

  def data
    orders.map do |order|
      array = []
      array << order.id
      array << order.delivery_method_vehicle_plate
      array << order.round
      array << order.client_business_name
      array << order.user_name.partition(" ").first.upcase
      array << order.total_amount.round
      array << link_to('Agregar entrega', edit_delivery_info_order_path(order), class: 'btn btn-success')
      array << link_to('Agregar pago', new_payment_path, class: 'btn btn-info')
      array << link_to('Envases', new_packaging_reception_path, class: 'btn btn-secondary')
      array
    end
  end

  def orders
    @orders ||= fetch_orders
  end

  def fetch_orders
    orders = Order.where('DATE(date) >= ?', Date.today).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    if params[:sSearch].present?
      orders = Order.includes(:delivery_method).where('DATE(date) >= ?', Date.today).where(delivery_methods: { vehicle_plate: params[:sSearch]&.strip}).page(page).per_page(per_page)
    end

    orders
  end

  def custom_sort
    case sort_column
    when 'clients.business_name'
      Order.includes(:client).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    when 'users.name'
      Order.includes(:user).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    when 'delivery_methods.vehicle_plate'
      Order.includes(:delivery_method).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    else
      Order.order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    end
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = ['orders.id', 'delivery_methods.vehicle_plate', 'clients.business_name', 'users.name', 'orders.total_amount']
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end
