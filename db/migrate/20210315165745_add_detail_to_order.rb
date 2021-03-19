class AddDetailToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :detail, :string
  end
end
