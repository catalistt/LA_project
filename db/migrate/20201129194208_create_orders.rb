class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :client, foreign_key: true
      t.references :user, foreign_key: true
      t.references :delivery_method, foreign_key: true
      t.float :net_amount
      t.float :total_iva
      t.float :total_extra_taxes
      t.float :total_amount
      t.float :total_packaging_amount
      t.datetime :visit_start
      t.datetime :visit_end
      t.float :discount_amount
      t.string :discount_comment
      t.boolean :create_invoive
      t.integer :responsable

      t.timestamps
    end
    #add_index :orders, [:client_id, :delivery_method_id], unique: true
  end
end
