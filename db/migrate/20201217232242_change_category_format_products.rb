class ChangeCategoryFormatProducts < ActiveRecord::Migration[5.2]
  def up
    change_column :products, :category, :integer
  end
  def down
    change_column :products, :category, :string
  end
end
