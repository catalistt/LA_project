class CreateAddItems < ActiveRecord::Migration[5.2]
  def change
    create_table :add_items do |t|
      t.references :product, foreign_key: true
      t.integer :quantity
      t.float :total_product_amount
      t.float :price
      t.date :expiration_date
      t.date :second_expiration_date
      t.references :purchase, foreign_key: true

      t.timestamps
    end
  end
end
