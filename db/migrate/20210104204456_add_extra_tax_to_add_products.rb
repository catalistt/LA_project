class AddExtraTaxToAddProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :add_products, :extra_tax, :float
  end
end
