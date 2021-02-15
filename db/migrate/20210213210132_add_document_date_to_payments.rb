class AddDocumentDateToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :check_date, :datetime
  end
end
