Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/show'
  get 'users/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:index]
  resources :users, only: [:show] do
    resources :posts, only: [:index]
  end
  resources :posts, only: [:show]
  
  root "users#index"
end

