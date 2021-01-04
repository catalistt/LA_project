class AddLineOfBusinessToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :line_of_business, :string
  end
end
