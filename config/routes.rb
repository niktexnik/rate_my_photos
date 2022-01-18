Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'photos#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :photos do
    member do
      get 'preview'
    end
    resources :comments, only: %i[create destroy edit update]
    resources :likes, only: %i[create destroy]
  end
  resources :collections do
    resources :photos
  end
end
