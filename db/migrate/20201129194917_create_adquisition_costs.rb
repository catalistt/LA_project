class CreateAdquisitionCosts < ActiveRecord::Migration[5.2]
  def change
    create_table :adquisition_costs do |t|
      t.references :product, foreign_key: true
      t.float :cost

      t.timestamps
    end
    #add_index :adquisition_costs, [:product_id], unique: true
  end
end
