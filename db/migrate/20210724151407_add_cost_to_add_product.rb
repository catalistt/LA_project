class AddCostToAddProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :add_products, :product_cost, :float
  end
end
