Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'orders/my_order' , to: "orders#my_order"
  get 'home/index'
  get 'home/dashboard'
  get 'orders/dashboard_clients'
  get 'add_products/search'
  resources :payments
  resources :payment_methods
  resources :adquisition_costs
  resources :stock_movements
  resources :add_products 
  resources :orders
  resources :purchases
  resources :group_discounts
  resources :products do
    get :set_price
  end
  
  resources :consumes
  resources :resources
  resources :delivery_methods
  resources :suppliers
  resources :clients
  resources :groups

  unauthenticated :user do
    root 'home#index'
  end
  
  authenticated :user do
    root "orders#new"
  end
  
end