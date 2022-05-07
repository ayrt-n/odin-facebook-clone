Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts, only: [:index, :new, :create] do
    resources :comments, only: [:create]
    resource :like, only: [:create, :destroy]
  end
  resources :friendships, only: [:create, :destroy]
end
