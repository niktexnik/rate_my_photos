Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'competitions#index'
  resources :competitions do
    post '/competitions/:id', to: 'photos#new'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :photos do
    resources :comments, only: %i[create destroy]
  end
end
