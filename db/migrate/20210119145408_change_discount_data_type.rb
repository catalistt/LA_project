class ChangeDiscountDataType < ActiveRecord::Migration[5.2]
  def change
    change_column :add_products, :discount, :float
   end
   
 end