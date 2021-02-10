class AddIdDocumentToStockMovement < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_movements, :id_document, :string
  end
end
