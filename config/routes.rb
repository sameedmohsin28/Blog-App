Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'sessions' => 'sessions#create'
      resources :users, only: [] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end

  devise_for :users
  get 'comments/new'
  get 'comments/create'
  get 'posts/index'
  get 'posts/show'
  get 'users/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show, :destroy] do
      resources :comments, only: [:index, :new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
  
end

