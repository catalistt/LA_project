class RenameCodToCodeInProducts < ActiveRecord::Migration[5.2]
  def up
    rename_column :products, :cod, :code
  end

  def down
    rename_column :products, :code, :cod
  end
end
