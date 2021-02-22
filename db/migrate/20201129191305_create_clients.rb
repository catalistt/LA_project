class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :business_name
      t.string :rut
      t.string :address
      t.references :user, foreign_key: true
      t.string :phone_number
      t.string :schedule
      t.string :special_agreement
      t.references :group, foreign_key: true

      t.timestamps
    end
    
  end
end
