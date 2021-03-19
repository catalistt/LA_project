module ApplicationHelper

  def afps
    ["AFP Capital","AFP Cuprum","AFP Habitat","AFP Modelo","AFP Planvital","AFP Provida"]
  end

  def health_system_name
    ["Isapre Banmédica", "Isapre Colmena", "Isapre Consalud", "Isapre Cruzblanca", "Isapre nueva masvida", "Isapre vida tres", "Fonasa A", "Fonasa B", "Fonasa C", "Fonasa D"]
  end

  def order_with_name
    orders_name = []
    Order.all.each do |order|
      element = ["#{order.id} - #{order.client}"]
      orders_name.push(element)
    end
    return orders_name
  end

  def order_status
    ["Pagada", "Pago incompleto", "Pendiente"]
  end

  def payment_name
    payments_name = []
    PaymentMethod.all.each do |payment|
      element = ["#{payment.id} - #{payment.name}"]
      payments_name.push(element)
    end
    return payments_name
  end

  def month_names
    ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre','Diciembre']
  end

  def glyphicon(name)
    "<span class='fa fa-#{name}'></span>"
  end

  def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
    end
  end

  def cities
    [["Región Metropolitana de Santiago",15],["Región de Arica y Parinacota",1],["Región de Tarapacá",2],["Región de Antofagasta",3],["Región de Atacama",4],["Región de Coquimbo",5],["Región de Valparaíso",6],["Región del Libertador General Bernardo O'Higgins",7],["Región del Maule",8],["Región del Biobío",9],["Región de La Araucanía",10],["Región de Los Ríos",11],["Región de Los Lagos",12],["Región Aysén del General Carlos Ibáñez del Campo",13], ["Región de Magallanes y de la Antártica Chilena",14]]
  end

  def towns
   [["Santiago",295], ["Cerrillos",296], ["Cerro Navia",297], ["Conchalí",298], ["El Bosque",299], ["Estación Central",300],["Huechuraba",301],["Independencia",302],["La Cisterna",303],["La Florida",304],["La Granja",305],["La Pintana",306],["La Reina",307],["Las Condes",308],["Lo Barnechea",309],["Lo Espejo",310],["Lo Prado",311],["Macul",312], ["Maipú",313],["Ñuñoa",314],["Pedro Aguirre Cerda",315],["Peñalolén",316],["Providencia",317],["Pudahuel",318],["Quilicura",319],["Quinta Normal",320],["Recoleta",321],["Renca",322],["San Joaquín",323],["San Miguel",324],["San Ramón",325], ["Vitacura",326], ["Puente Alto",327],["Pirque",328],["San José de Maipo",329],["Colina",330],["Lampa",331], ["Til Til",332],["San Bernardo",333],["Buin",334],["Calera de Tango",335], ["Paine",336],["Melipilla",337],["Alhué",338],["Curacaví", 339],["María Pinto",340],["San Pedro",341],["Talagante",342],["El Monte",343],["Isla de Maipo",344],["Padre Hurtado",345],["Peñaflor",346]]
  end
end
