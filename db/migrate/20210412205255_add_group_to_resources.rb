class AddGroupToResources < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :group, :string
  end
end
