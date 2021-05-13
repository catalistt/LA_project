class RemoveExtraTaxFromProduct < ActiveRecord::Migration[5.2]
  def up
    remove_column :products, :extra_tax
  end

  def down
    add_column :products, :extra_tax
  end
end
