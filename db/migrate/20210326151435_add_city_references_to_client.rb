class AddCityReferencesToClient < ActiveRecord::Migration[5.2]
  def change
    add_reference :clients, :city, foreign_key: true
  end
end
