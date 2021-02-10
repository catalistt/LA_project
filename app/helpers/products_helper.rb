module ProductsHelper

  def translate_category(category)
    categorias_esp = {soda: "Bebida",beer: "Cerveza",wine: "Vino",snack: "Snack",water: "Agua"}
    categorias_esp[category.to_sym]
  end

  def categories
  [["ENERGETICA", "energetic"], ["BEBIDA ISOTONICA", "isotonic"], ["NECTAR", "nectar"], ["PROMOCION", "promotion"], ["SERVICIO", "service"], ["TE", "tea"], ["BEBIDA", "soda"], [ "CERVEZA", "beer"], ["VINO", "wine"], ["SNACK", "snack"], ["AGUAS","water"]]
  end

  def taxes
    [["Cervezas y otros alcoholes", 0.18], [ "Bebidas azucaradas", 0.25]]
  end

  def product_costs
    [['Ruta', 1], ['Precio 1', 0.055], ['Precio 2', 0.075], ['Precio 3', 0.095], ['Precio 4', 0.115]]
  end

end
