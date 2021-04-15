class ChangeExtraTaxType < ActiveRecord::Migration[5.2]
  def up
    change_column :products, :extra_tax, :integer
  end
  def down
    change_column :products, :extra_tax, :float
  end
end
