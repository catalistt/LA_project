class AddAmountToMoneyMovement < ActiveRecord::Migration[5.2]
  def change
    add_column :money_movements, :amount_payed, :integer
  end
end
