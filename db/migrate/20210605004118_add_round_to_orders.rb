class AddRoundToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :round, :integer
  end
end
