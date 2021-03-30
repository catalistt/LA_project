class AddCommuneReferenceToClient < ActiveRecord::Migration[5.2]
  def change
    add_reference :clients, :commune, foreign_key: true
  end
end
