class AssignDeliveryMethodDatatable
  delegate :params, :h, :link_to, :number_to_currency, :options_from_collection_for_select, :select_tag, to: :@view
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
      array << order.client&.business_name
      array << order.user&.name
      array << order.client&.commune&.name
      array << order.total_packaging('desechable')
      array << order.total_packaging('retornables')
      array << order.total_packaging('3l')
      array << order.total_packaging('cervezas')
      array << order.total_amount.round
      array << order.detail
      array << order.delivery_method&.vehicle_plate
      array << select_tag(:delivery_method_id, options_from_collection_for_select(DeliveryMethod.all, :id, :vehicle_plate, {include_blank: 'Elige patente'}), { class: "custom-select delivery_method_id"})
      array
    end
  end

  def orders
    @orders ||= fetch_orders
  end

  def fetch_orders
    orders = Order.where('DATE(date) >= ?', Date.today).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    if params[:sSearch].present?
      orders = orders.where("CAST(orders.id AS TEXT) ILIKE :search OR orders.name ILIKE :search", search: "%#{params[:sSearch]}%")
    end

    orders
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = ['orders.id', 'orders.name']
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end
