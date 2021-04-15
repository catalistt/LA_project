class RemoveExtraTaxFromProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :extra_tax
  end
end
