class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :order, foreign_key: true
      t.references :payment_method, foreign_key: true
      t.float :amount_payed
      t.integer :status

      t.timestamps
    end
    #add_index :payments, [:order_id], unique: true
  end
end
