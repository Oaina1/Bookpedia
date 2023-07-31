Rails.application.routes.draw do

  post 'cart/add_to_cart', to: 'cart#add_to_cart', as:  'add_to_cart'
  get 'cart', to: 'cart#index', as: 'cart'
  patch 'cart/update_quantity', to: 'cart#update_quantity', as: 'update_quantity_cart'
  delete 'cart/remove_item', to: 'cart#remove_item', as: 'remove_from_cart'

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
  end

end
