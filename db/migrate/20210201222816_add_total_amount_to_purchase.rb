class AddTotalAmountToPurchase < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :total_amount, :float
  end
end
