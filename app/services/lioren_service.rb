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
        'impuestoadicional': product.tax_code
      }
    end
  end

  def post_dte
    uri = URI.parse("#{lioren_api_url}dtes")
    http = Net::HTTP.new(uri.host, uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    headers = {
      'Authorization'=>"Bearer #{@token}",
      'Content-Type' =>'application/json',
      'Accept'=>'application/json'
    }
    req = Net::HTTP::Post.new(uri.request_uri, headers)
    req.body = build_invoice.to_json
    response = http.request(req)
    puts response
    begin
      JSON.parse(response.body)
    rescue
      response.body
    end
  end

  def lioren_api_url
    ENV['LIOREN_URL']
  end
end