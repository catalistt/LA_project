class CreateCity < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
