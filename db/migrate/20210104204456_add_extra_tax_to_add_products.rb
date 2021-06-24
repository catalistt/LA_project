class AddExtraTaxToAddProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :add_products, :extra_tax, foreign_key: true
  end
end
