class ChangeResponsableType < ActiveRecord::Migration[5.2]
  def up
    change_column :orders, :responsable, :string
  end
  def down
    change_column :orders, :responsable, :integer
  end
end
