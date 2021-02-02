class RemoveProductFromPurchase < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchases, :product_id
  end
end
