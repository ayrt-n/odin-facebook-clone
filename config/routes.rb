Rails.application.routes.draw do
  root 'posts#index'

  # Routes for users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users

  # Routes for post-system
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :like, only: [:create, :destroy]
  end

  # Routes for friendship-system
  resources :friendships, only: [:index, :create, :destroy]
  resources :friend_requests, only: [:index, :create, :destroy] do
    post :accept, on: :member
    post :decline, on: :member
  end
end
