ActiveAdmin.register Product do
  permit_params :cod, :name, :category, :packaging, :format, :description, :unit, :extra_tax, :stardard_price, :created_at
  index do
    column :cod
    column :name
    column :category
    column :packaging
    column :format
    column :description
    column :unit
    column :extra_tax
    column :stardard_price
    column :created_at
    actions
  end
end