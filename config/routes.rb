Rails.application.routes.draw do
  resources :taxes
  resources :cash_registers
  resources :money_movements do
    collection do
      get :square
    end
  end
  resources :add_items
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :edit, :update]  
  get 'orders/my_order', to: "orders#my_order"
  get 'payments/set_pendings', to: "payments#set_pendings"
  get 'resources/resource_amount', to: "resources#resource_amount"
  get 'payments/pending', to: "payments#pending"
  get 'home/index'
  get 'home/dashboard'
  get 'orders/dashboard_clients'
  get 'orders/my_detail'
  get 'orders/loading_sheets'
  get 'add_products/print_detail'
  get 'orders/today_pending'
  resources :payments do
    collection do
      get :delivery_payments
    end
  end
  resources :payment_methods
  resources :adquisition_costs
  resources :stock_movements
  resources :add_products
  resources :orders do
    member do
      get :edit_delivery_info
      put :update_delivery_info
    end
    collection do
      get :filter
      post :search
      get :delivery_orders
      put :update_all
      get :edit_all
    end
  end
  resources :purchases
  resources :group_discounts
  resources :products do
    collection do
      get :presale_sheet
    end
    get :set_price
    get :set_product_stock
    member do
      get 'group_discount/:client_id', to: 'products#group_discount'
    end
  end

  resources :consumes do
    collection do
      get :collation
      get :other_consumes
    end
  end
  resources :resources
  resources :delivery_methods
  resources :suppliers
  resources :clients do
    get :group
  end
  resources :groups

  unauthenticated :user do
    root 'home#index'
  end

  authenticated :user do
    root "orders#new"
  end

end