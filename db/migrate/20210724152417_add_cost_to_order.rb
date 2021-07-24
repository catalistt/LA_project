class AddCostToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_cost, :float
  end
end
