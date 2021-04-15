class CreateCommune < ActiveRecord::Migration[5.2]
  def change
    create_table :communes do |t|
      t.string :name
      t.string :code
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
