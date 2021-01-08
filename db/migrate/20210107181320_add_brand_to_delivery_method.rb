class AddBrandToDeliveryMethod < ActiveRecord::Migration[5.2]
  def change
    add_column :delivery_methods, :brand, :string
    add_column :delivery_methods, :vehicle_model, :string
    add_column :delivery_methods, :max_weight, :string
    add_column :delivery_methods, :consume, :string
    add_column :delivery_methods, :emergency_number, :string
    add_column :delivery_methods, :last_revision, :date
  end
end
