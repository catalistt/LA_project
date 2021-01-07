class RemoveIndexesFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_index :add_products, name: "index_orders_on_client_id_and_delivery_method_id"
  end
end
