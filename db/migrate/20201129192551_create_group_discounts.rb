class CreateGroupDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :group_discounts do |t|
      t.references :product_id, foreign_key: true
      t.references :group_id, foreign_key: true
      t.float :discount

      t.timestamps
    end
  end
end
