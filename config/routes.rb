Rails.application.routes.draw do
  resources :payments
  resources :payment_methods
  resources :adquisition_costs
  resources :stock_movements
  resources :add_products
  resources :orders
  resources :purchases
  resources :group_discounts
  resources :products
  resources :consumes
  resources :resources
  resources :delivery_methods
  resources :suppliers
  resources :clients
  resources :groups
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
