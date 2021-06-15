class AddPdfTextToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :pdf_text, :string
  end
end
