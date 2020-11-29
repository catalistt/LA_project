class CreateGroupDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :group_discounts do |t|
      t.references :product, foreign_key: true
      t.references :group, foreign_key: true
      t.float :discount

      t.timestamps
    end
    #add_index :group_discounts, [:group_id, :product_id], unique: true
  end
end
