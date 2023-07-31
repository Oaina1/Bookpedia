Rails.application.routes.draw do
  # get 'books/index'
  # get 'books/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :genres do
    resources :books, only: :index
  end

  resources :books, only: [:index, :show]

end
