class AddTaxReferenceToProduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :tax, foreign_key: true
  end
end
