class CreateMoneyMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :money_movements do |t|
      t.integer :movement_type
      t.string :payment_method
      t.date :check_date
      t.string :received_by
      t.string :movement_category
      t.string :comment

      t.timestamps
    end
  end
end
