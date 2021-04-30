module PackagingReceptionsHelper
  def vehicle(delivery)
    DeliveryMethod.find(delivery).vehicle_plate
  end

end
