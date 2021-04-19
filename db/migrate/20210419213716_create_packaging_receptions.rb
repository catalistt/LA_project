class CreatePackagingReceptions < ActiveRecord::Migration[5.2]
  def change
    create_table :packaging_receptions do |t|
      t.references :client, foreign_key: true
      t.integer :total_box_amount
      t.integer :total_payed

      t.timestamps
    end
  end
end
