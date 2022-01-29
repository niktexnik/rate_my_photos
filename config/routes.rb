Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: 'photos#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :comments do
    resources :comments
  end

  resources :photos, only: %i[index] do
    get :preview, on: :member
    resources :comments, only: %i[create destroy edit update]
    resources :likes, only: %i[create destroy]
  end

  namespace :users do
    resources :photos
  end

  namespace :moderate do
    resources :photos
  end

  namespace :api do
    resources :photos
    resources :users
    resources :comments
  end
end
