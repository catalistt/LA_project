class AddDeliveryMethodToPackagingReception < ActiveRecord::Migration[5.2]
  def change
    add_reference :packaging_receptions, :delivery_method, foreign_key: true
    add_column :packaging_receptions, :turn, :integer
  end

end
