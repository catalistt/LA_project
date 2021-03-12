class AddCityToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :city, :integer
    add_column :clients, :town, :integer
  end
end
