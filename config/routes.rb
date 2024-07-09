# config/routes.rb
Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Root route pointing to posts#index
  root "posts#index"

  # Routes for users including following and followers actions
  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
      post :follow, to: 'relationships#create'
      delete :unfollow, to: 'relationships#destroy'
    end
  end

  # Nested routes for posts with likes nested under posts
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :update, :destroy]
  end

  # Routes for creating and destroying relationships
  resources :relationships, only: [:create, :destroy]

  # Health check route to verify app status
  get "up" => "rails/health#show", as: :rails_health_check
end
