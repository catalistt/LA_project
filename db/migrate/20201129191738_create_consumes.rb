class CreateConsumes < ActiveRecord::Migration[5.2]
  def change
    create_table :consumes do |t|
      t.references :user, foreign_key: true
      t.references :resource, foreign_key: true
      t.integer :quantity
      t.float :total_amount

      t.timestamps
    end
  end
end
