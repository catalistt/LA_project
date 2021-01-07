class RemoveIndexFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_index :add_products, name:  "index_add_products_on_order_id_and_product_id"
  end
end
