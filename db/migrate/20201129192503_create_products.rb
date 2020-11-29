class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :cod
      t.string :name
      t.string :type
      t.string :packaging
      t.string :format
      t.string :description
      t.string :unit
      t.float :extra_tax
      t.float :stardard_price

      t.timestamps
    end
  end
end
