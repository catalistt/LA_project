Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "orders/my_order", to: "orders#my_order"
  get 'home/index'
  get 'home/dashboard'
  get 'orders/dashboard_clients'
  resources :payments
  resources :payment_methods
  resources :adquisition_costs
  resources :stock_movements
  resources :add_products do
    get :st_price
  end
  resources :orders
  resources :purchases
  resources :group_discounts
  resources :products do
    get :st_price
  end
  
  resources :consumes
  resources :resources
  resources :delivery_methods
  resources :suppliers
  resources :clients
  resources :groups
  devise_for :users


  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end