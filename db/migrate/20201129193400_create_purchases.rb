class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :product_id, foreign_key: true
      t.references :supplier_id, foreign_key: true
      t.integer :invoice_number
      t.float :price
      t.integer :quantity
      t.float :subtotal
      t.datetime :expiration_date
      t.datetime :second_expiration_date

      t.timestamps
    end
  end
end
