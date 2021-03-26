class RenameTypeColumn < ActiveRecord::Migration[5.2]
  def change
      rename_column :consumes, :type, :category
  end
end
