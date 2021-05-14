class OrdersDatatable
  delegate :params, :h, :link_to, :number_to_currency, :content_tag, :raw,:button_tag, to: :@view
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
      array << order.created_at.to_date
      array << order.client_business_name
      array << order.user_name
      array << order.total_amount.round
      array << order.delivery_method_vehicle_plate
      array << order.responsable
      array << order.discount_amount
      array << order.discount_comment
      array << order.create_invoive? ? 'Si' : 'No'
      array << link_to(raw("<i class='fa fa-eye'></i>"), order_path(order), class: 'btn btn-info btn-xs mr-1') + link_to(raw("<i class='fa fa-edit'></i>"), edit_order_path(order), class: 'btn btn-success btn-xs mr-1') + link_to(raw("<i class='fa fa-trash'></i>"), order_path(order), class: 'btn btn-danger btn-xs', method: :delete)
      array <<  + check_invoice(order)
      array
    end
  end

  def check_invoice(order)
    if order.pdf_text.present?
      button_tag(raw("<i class='fa fa-file'></i>"), type: :button, class: 'btn btn-info btn-xs mr-1 create_invoice_btn', data: {oid: order.id}) + link_to(raw('<i class="fa fa-download"></i>'), download_dte_order_path(order), method: :get, class: "btn btn-success btn-xs ", id: "download_invoice_#{order.id}")
    else
      button_tag(raw("<i class='fa fa-file'></i>"), type: :button, class: 'btn btn-info btn-xs mr-1 create_invoice_btn', data: { oid: order.id })
    end
  end

  def orders
    @orders ||= fetch_orders
  end

  def fetch_orders
    orders = custom_sort
    if params[:sSearch].present?
      orders = orders.where("CAST(orders.id AS TEXT) ILIKE :search", search: "%#{params[:sSearch]}%").page(page).per_page(per_page)
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
    columns = ['orders.created_at', 'clients.business_name', 'users.name', 'orders.total_amount', 'delivery_methods.vehicle_plate', 'orders.responsable', 'orders.discount_amount', 'orders.discount_comment', 'orders.create_invoive', 'orders.created_at']
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end
