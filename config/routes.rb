Rails.application.routes.draw do
  root 'posts#index'

  # Routes for users
  devise_for :users
  resources :users
  
  # Routes for post-system
  resources :posts, only: [:index, :show, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    resource :like, only: [:create, :destroy]
  end

  # Routes for friendship-system
  resources :friendships, only: [:create, :destroy]
  resources :friend_requests, only: [:index, :create, :destroy] do
    post :accept, on: :member
    post :decline, on: :member
  end
end
