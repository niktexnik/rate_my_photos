Rails.application.routes.draw do
  require 'sidekiq/web'

  authenticate :admin_user, ->(user) { user } do
    mount Sidekiq::Web => '/sidekiq'
  end

  scope :admin do
    ActiveAdmin.routes(self)
    devise_for :admin_users, ActiveAdmin::Devise.config
    get 'admin/index', to: 'admin/notification#index'
  end

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
    resources :photos do
      get '/restore', to: 'photos#restore', as: :restore
    end
  end

  namespace :api do
    resources :users
    resources :photos do
      resources :comments
      resources :likes
    end
  end

  put 'users/updatekey', to: 'users#update_key'
end
