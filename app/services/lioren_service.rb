class LiorenService

  attr_accessor :client

  def initialize(order)
    @order = order
    @client = order.client
    @token = ENV['LIOREN_AUTH_TOKEN']
  end

  def build_invoice(doc_type)
    dte_code = dte_type.eql?('invoice') ? '33' : '39'
    @invoice = {
      emisor: {
        tipodoc: dte_code,
        fecha: @order.date.strftime('%Y-%m-%d')
      },
      receptor: {
        rut: @client.rut,
        rs: @client.business_name,
        giro: @client.line_of_business,
        comuna: @client.commune.code.to_i,
        ciudad: @client.city.code.to_i,
        direccion: @client.address
      },
      detalles: [],
      expects: 'pdf'
    }
    @invoice[:detalles] << {
      codigo: '9999',
      nombre: 'Flete',
      cantidad: 1,
      precio: @order.freight.round(2),
      exento: false,
    }
    @order.add_products.each do |add_product|
      product = add_product.product
      @invoice[:detalles] << {
        codigo: product.code.to_s,
        nombre: product.name,
        cantidad: add_product.quantity,
        precio: add_product.net_product_amount.round(2),
        exento: false,
      }
    end
    @invoice
  end

  def post_dte(dte_type)
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
    req.body = build_invoice(dte_type).to_json
    puts req.body
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