module ProductsHelper

  def translate_category(category)
    categorias_esp = {soda: "Bebida",beer: "Cerveza",wine: "Vino",snack: "Snack",water: "Agua"}
    categorias_esp[category.to_sym]
  end

  def categories
  [["Bebida", "soda"], [ "Cerveza", "beer"], ["Vino", "wine"], ["Snack", "snack"], ["Agua","water"]]
  end

  def taxes
    [["Cervezas y otros alcoholes", 0.18], [ "Bebidas azucaradas", 0.25]]
  end

end
