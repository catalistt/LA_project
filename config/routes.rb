Rails.application.routes.draw do
  resources :cash_registers 
  resources :money_movements do
    collection do
      get :square
    end
  end
  resources :add_items
  match 'orders/all/edit' => 'orders#edit_all', :as => :edit_all, :via => :get
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
  resources :payments
  resources :payment_methods
  resources :adquisition_costs
  resources :stock_movements
  resources :add_products
  get 'orders/edit_delivery_fields/:id', to: 'orders#edit_delivery_fields', as: :delivery_edit
  resources :orders do
    collection do
      get :filter
      post :search
      get :delivery_orders
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

  resources :consumes
  resources :resources
  resources :delivery_methods do
    collection do
      put :update_orders
    end
  end
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