class CreateCashRegisters < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_registers do |t|
      t.string :initial_cash
      t.string :final_cash

      t.timestamps
    end
  end
end
