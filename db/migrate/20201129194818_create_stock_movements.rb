class CreateStockMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_movements do |t|
      t.references :product, foreign_key: true
      t.integer :initial_stock
      t.integer :added
      t.integer :removed
      t.integer :final_stock

      t.timestamps
    end
    #add_index :stock_movements, [:product_id], unique: true
  end
end
