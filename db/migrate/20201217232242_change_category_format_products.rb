class ChangeCategoryFormatProducts < ActiveRecord::Migration[5.2]
  def up
    change_column :products, :category, 'integer USING CAST(category AS integer)'
  end
  def down
    change_column :products, :category, :string
  end
end
