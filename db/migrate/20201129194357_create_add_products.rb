class CreateAddProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :add_products do |t|
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true
      t.string :price
      t.integer :discount
      t.integer :quantity
      t.float :total_product_amount
      t.float :packaging_amount

      t.timestamps
    end
    #add_index :add_products, [:order_id, :product_id], unique: true
  end
end
