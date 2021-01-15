class AddNetProductAmountInAddProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :add_products, :net_product_amount, :float
  end
end
