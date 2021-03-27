class AssignDeliveryMethodDatatable
  delegate :params, :h, :link_to, :number_to_currency, :options_from_collection_for_select, :select_tag, :content_tag, :hidden_field_tag, to: :@view
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
      array << content_tag(:div) do
        hidden_field_tag :id, order.id, class: 'order_id'
      end
      array << order.client_business_name
      array << order.user_name
      array << order.client&.commune_name
      array << order.total_packaging('DESECHABLE')
      array << order.total_packaging('RETORNABLES')
      array << order.total_packaging('3L')
      array << order.total_packaging('CERVEZAS')
      array << order.total_amount.round
      array << order.detail
      array << order.delivery_method_vehicle_plate
      array << select_tag(:delivery_method_id, options_from_collection_for_select(DeliveryMethod.all, :id, :vehicle_plate, {include_blank: 'Elige patente', selected: order.delivery_method_id }), { class: "custom-select delivery_method_id"})
      array
    end
  end

  def orders
    @orders ||= fetch_orders
  end

  def fetch_orders
    orders = custom_sort
    if params[:sSearch].present?
      orders = orders.where("CAST(orders.id AS TEXT) ILIKE :search OR orders.name ILIKE :search", search: "%#{params[:sSearch]}%")
    end

    orders
  end

  def custom_sort
    case sort_column
    when 'clients.business_name'
      Order.includes(:client).where('DATE(date) >= ?', Date.today).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    when 'users.name'
      Order.includes(:user).where('DATE(date) >= ?', Date.today).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    when 'communes.name'
      Order.includes(:commune).where('DATE(date) >= ?', Date.today).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    when 'orders.disposable'
      order_by_packaging_type('DESECHABLE')
    when 'orders.returnable'
      order_by_packaging_type('RETORNABLE')
    when 'orders.three_l'
      order_by_packaging_type('3L')
    when 'orders.beers'
      order_by_packaging_type('CERVEZAS')
    when 'delivery_methods.vehicle_plate'
      Order.includes(:delivery_method).where('DATE(date) >= ?', Date.today).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    else
      Order.where('DATE(date) >= ?', Date.today).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
    end
  end

  def order_by_packaging_type(packaging_type)
    packagings = Order.where('DATE(date) >= ?', Date.today).joins(:products).where(products: { packaging: packaging_type }).group(:order_id).count(:product_id)
    if sort_direction.eql?('asc')
      packagings = packagings.sort_by { |_k, v| v }
    else
      packagings = packagings.sort_by { |_k, v| v }.reverse
    end
    order_ids = packagings.map { |k, _v| k }
    Order.where(id: order_ids).page(page).per_page(per_page)
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = ['orders.id', 'clients.business_name', 'users.name', 'communes.name', 'orders.disposable', 'orders.returnable', 'orders.three_l', 'orders.beers', 'orders.total_amount', 'orders.detail', 'delivery_methods.vehicle_plate']
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end
