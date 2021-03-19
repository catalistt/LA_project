class ChangePaymentDataType < ActiveRecord::Migration[5.2]
  def change
    remove_column :money_movements, :payment_method, :string
    add_column :money_movements, :payment_method, :integer, references: :payment_method
  end
end
