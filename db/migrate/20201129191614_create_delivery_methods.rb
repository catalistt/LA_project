class CreateDeliveryMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_methods do |t|
      t.string :vehicle_plate
      t.datetime :adquisition_date
      t.integer :policy_number
      t.string :ensurance_company

      t.timestamps
    end
  end
end
