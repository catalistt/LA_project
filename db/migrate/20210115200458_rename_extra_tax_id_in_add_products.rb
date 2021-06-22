class RenameExtraTaxIdInAddProducts < ActiveRecord::Migration[5.2]
  def up
    rename_column :add_products, :extra_tax_id, :extra_tax
  end

  def down
    rename_column :add_products, :extra_tax, :extra_tax_id
  end
end