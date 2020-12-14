ActiveAdmin.register Client do
  permit_params :business_name, :rut, :address, :user_id, :phone_number, :schedule, :special_agreeement, :group_id
  index do
    column :business_name
    column :rut
    column :address
    column :user_id
    column :phone_number
    column :schedule
    column :special_agreeement
    column :group_id
    actions
  end
end