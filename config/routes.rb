Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'tweets#index'
  get 'search_user', to: 'users#search_user'
  post 'search_user', to: 'users#search_user'
  get '/:username', to: 'users#show', as: :user

  scope ':username' do
    resource :following, only: [:show]
    resource :followers, only: [:show]
  end

  resources :tweets, except: [:new]
  resources :relationships, only: [:create, :destroy]
end
