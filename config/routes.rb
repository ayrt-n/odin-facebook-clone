Rails.application.routes.draw do
  root 'posts#index'

  # Routes for users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :users do
    get 'search', on: :collection
  end

  # Routes for post-system
  resources :posts do
    resources :comments, only: %i[create destroy]
    resource :like, only: %i[create destroy]
  end

  # Routes for friendship-system
  resources :friend_requests, only: %i[index create destroy] do
    post :accept, on: :member
    post :decline, on: :member
  end
end
