class AddPackagingAmountToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :packaging_amount, :integer
  end
end
