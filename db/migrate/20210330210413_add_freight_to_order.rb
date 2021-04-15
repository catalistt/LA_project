class AddFreightToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :freight, :float
  end
end
