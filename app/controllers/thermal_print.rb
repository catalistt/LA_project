class ThermalPrint < Escpos::Report

  def order
    options[:order]
  end

end