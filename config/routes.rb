Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :tweets
  resources :relationships, only: [:create, :destroy]
  root 'tweets#index'
end
