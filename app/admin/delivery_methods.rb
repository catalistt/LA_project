ActiveAdmin.register DeliveryMethod do
  permit_params :vehicle_plate, :adquisition_date, :policy_number, :ensurance_company
  index do
    column :vehicle_plate
    column :adquisition_date
    column :policy_number
    column :ensurance_company
    actions
  end
end