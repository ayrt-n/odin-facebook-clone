Rails.application.routes.draw do
  # Root route based on authentication
  devise_scope :user do
    authenticated :user do
      root 'posts#index'
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # Routes for users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :users
  resources :friends, only: %i[index]

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
