class ChangeMovementTypeColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :stock_movements, :movement_type, :string
  end
end
