Rails.application.routes.draw do
  root 'posts#index'

  # Routes for users
  devise_for :users
  resources :users
  
  # Routes for post-system
  resources :posts, only: [:index, :new, :create] do
    resources :comments, only: [:create]
    resource :like, only: [:create, :destroy]
  end

  # Routes for friendship-system
  resources :friendships, only: [:create, :destroy]
  resources :friend_requests, only: [:create, :destroy]
end
