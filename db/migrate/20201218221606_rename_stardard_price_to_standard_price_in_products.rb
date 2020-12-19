class RenameStardardPriceToStandardPriceInProducts < ActiveRecord::Migration[5.2]
  def up
    rename_column :products, :stardard_price, :standard_price
  end

  def down
    rename_column :products, :standard_price, :stardard_price
  end
end
