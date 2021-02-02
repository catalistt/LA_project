class RemoveIndexFromPurchase < ActiveRecord::Migration[5.2]
  def change
    remove_index :purchases, name: "index_purchases_on_product_id_and_supplier_id"
    remove_index :purchases, name: "index_purchases_on_product_id"
    remove_index :purchases, name: "index_purchases_on_supplier_id"
  end
end
