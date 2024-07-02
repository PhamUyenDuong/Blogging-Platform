Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # Root route pointing to posts#index
  root "posts#index"

  resources :users, only: [:show]

  # Routes for users including following and followers actions
  resources :users do
    member do
      get :following, :followers
    end
  end

  # resources :posts do
  #   resources :comments, only: [:create, :destroy]
  # end

  # Nested routes for posts with likes nested under posts
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  # Routes for creating and destroying relationships
  resources :relationships, only: [:create, :destroy]

  # Health check route to verify app status
  get "up" => "rails/health#show", as: :rails_health_check
end
