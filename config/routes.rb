Rails.application.routes.draw do
  get 'orders/index'
  get 'current_user/index'
  # devise_for :users, path: '', path_names: {
  #   sign_in: 'login',
  #   sign_out: 'logout',
  #   registration: 'signup'
  # },
  #  controllers: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations'
  # }
  # devise_for :users, controllers: {
  #    sessions: 'users/sessions',
  #   registrations: 'users/registration'
  # }
  # scope :api, defaults: { format: :json } do
  #   scope :v1 do
  #     devise_for :users
  #   end
  # end
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registrations'
      }, path: '',path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    }
    end
  end
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'current_user/index'

  default_url_options :host => "localhost:3000"
  namespace :api do
    namespace :v1 do
     
      # get 'products/index'
      # get 'products/create'
      
       resources :products, only: [:index, :show]
       # only: [:show, :create, :index]
       # get 'products/show'
       get 'carts/index'
       get 'carts/show'
       # get 'carts/create'
       # get 'carts/address', to: 'carts#address'

      resources :carts do 
        post "address_create", on: :collection
      end

      namespace :admin do
        resources :products, only: [:create, :update, :destroy]
      end

      get '/order_items/:product_id/add_to_cart', to: 'order_items#add_to_cart', as: :add_to_cart
      delete '/order_items/:id', to: 'order_items#destroy', as: :remove_order_item


    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'home/index'
  get 'home/users'
  get 'home/about'
  # resources :users;
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#index"
  # resources :order_items do
  #   member do
  #     post 'add_to_cart' 
  #   end
  # end
  
  get '/products', to: 'home#index'
  #get '/search', to: 'home#search'

  get '/order_items/:product_id/add_to_cart', to: 'order_items#add_to_cart', as: :add_to_cart
  delete '/order_items/:id', to: 'order_items#destroy', as: :remove_order_item

  
  #resources :carts
  #get "/carts" , to: "carts#show"
  resources :carts, only: :index
  get '/cart', to: 'carts#cart', as: :cart
  get '/carts/address', to: 'carts#address'
  post 'carts/address_create', to: 'carts#address_create'
  delete 'carts/address_destroy', to: 'carts#remove_address'
  put '/assign_address', to: 'carts#assign_address'
  get '/carts/payment', to: 'carts#payment'
  post 'carts/payment_success', to: 'carts#payment_success'
  get '/carts/complete', to: 'carts#complete'


  delete 'api/v1/carts/remove_address/:id', to: 'api/v1/carts#remove_address'
end
