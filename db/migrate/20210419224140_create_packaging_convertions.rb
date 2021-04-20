class CreatePackagingConvertions < ActiveRecord::Migration[5.2]
  def change
    create_table :packaging_convertions do |t|
      t.string :name
      t.integer :cost
      t.references :supplier, foreign_key: true
      t.timestamps
    end
  end
end
