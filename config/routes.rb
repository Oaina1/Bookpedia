Rails.application.routes.draw do
  get 'orders/index'


  post 'cart/add_to_cart', to: 'cart#add_to_cart', as: 'add_to_cart'
  get 'cart', to: 'cart#index', as: 'cart'
  patch 'cart/update_quantity', to: 'cart#update_quantity', as: 'update_quantity_cart'
  delete 'cart/remove_item', to: 'cart#remove_item', as: 'remove_from_cart'

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'index', to: 'checkout#index', as: 'checkout_index'
    get 'guest', to: 'checkout#guest', as: 'guest'
    post 'save_guest_details', to: 'checkout#save_guest_details', as: 'save_guest_details'

  end

  resources :customer, only: [:show]
  devise_for :customers
  get 'about_pages/show'
  get 'contact_pages/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # get 'books/index'
  # get 'books/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "books#index"

  resources :genres do
    resources :books, only: :index
  end

  resources :books, only: [:index, :show] do
    collection do
      get 'filter'
      get "search"
    end
    member do
      post 'add_to_cart'
    end
  end

end
