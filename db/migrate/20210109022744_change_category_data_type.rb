class ChangeCategoryDataType < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :category, :string
  end
end
