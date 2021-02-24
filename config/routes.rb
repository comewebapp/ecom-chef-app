Rails.application.routes.draw do
  apipie
  get 'home/index'
  resources :collections
  resources :products
  resources :orders
  # devise_for :users
  devise_for :users, :controllers => {:registrations => 'users/registrations'}

  root 'products#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get 'profile', action: :profile, controller: 'home'

  namespace :admin do
    root "/admin/dashboard#index"
    resources :dashboard
    resources :users
    resources :products do
      member do
        put :approve
      end
    end
    resources :collections
    resources :settings, only: [:index, :create, :update] do
      collection do
        post :reset_stock
      end
    end
  end
end
