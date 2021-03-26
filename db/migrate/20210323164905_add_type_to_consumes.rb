class AddTypeToConsumes < ActiveRecord::Migration[5.2]
  def change
    add_column :consumes, :type, :string
  end
end
