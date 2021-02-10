class AddMovementToStockMovement < ActiveRecord::Migration[5.2]
  def change
    remove_column :stock_movements, :added, :integer
    remove_column :stock_movements, :removed, :integer
    add_column :stock_movements, :movement_type, :boolean
    add_column :stock_movements, :stock_quantity, :integer
  end
end
