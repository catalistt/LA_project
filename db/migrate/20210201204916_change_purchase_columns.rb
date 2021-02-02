class ChangePurchaseColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchases, :price
    remove_column :purchases, :quantity
    remove_column :purchases, :subtotal
    remove_column :purchases, :expiration_date
    remove_column :purchases, :second_expiration_date
  end
end