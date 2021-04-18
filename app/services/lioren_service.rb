class LiorenService

  def initialize(order)
    @order = order
    @client = order.client
    @token = ENV['LIOREN_AUTH_TOKEN']
  end

  def build_invoice
    @invoice = {
      'emisor': {
        'tipodoc': '33',
        'fecha': @order.date
      },
      'receptor': {
        'rut': @client.rut,
        'rs': @client.business_name,
        'giro': @client.line_of_business,
        'comuna': @client.commune.code,
        'cuidad': @client.city.code,
        'direccion': @client.address
      },
      'detalles': []
    }
    @order.add_products.each do |add_product|
      product = add_product.product
      @invoice['detalles'] << {
        'codigo': product.code,
        'nombre': product.name,
        'cantidad': add_product.quantity,
        'price': add_product.net_product_amount,
        'exento': false,
        'impuestoadicional': product.extra_tax
      }
    end
  end

  def send_invoice
  end
end