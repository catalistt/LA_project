module ProductsHelper

  def translate_category(category)
    categorias_esp = {soda: "Bebida",beer: "Cerveza",wine: "Vino",snack: "Snack",water: "Agua",freight: "Flete"}
    categorias_esp[category.to_sym]
  end

  def categories
  [["Energetica", "energetic"], ["Bebida isotónica", "isotonic"], ["Nectar", "nectar"], ["Promocion", "promotion"], ["Servicio", "service"], ["Té", "tea"], ["Bebida", "soda"], [ "Cerveza", "beer"], ["Vino", "wine"], ["Snack", "snack"], ["Aguas","water"], ["Flete", "freight"]]
  end

  def taxes
    [["Cervezas y otros alcoholes", 0.18], [ "Bebidas azucaradas", 0.25]]
  end

  def product_costs
    [['Ruta', 1], ['Precio 1', 0.135], ['Precio 2', 0.115], ['Precio 3', 0.095], ['Precio 4', 0.075], ['Precio 5', 0.055]]
  end

  def pack
    ['Desechable', 'Retornable', '3L', 'Cervezas','Bidon', 'Otro']
  end

  def get_totaled(p_id)
    @code_totaled = Order.joins(:add_products).where("DATE(date) >= ?", Date.today).where("delivery_method_id = ?", 2).where(add_products: {product_id: p_id}).sum(:quantity)
  end

  def products_with_stock
    @products_with_stock = Product.where("stock > ?", 0)
  end


end
