Rails.application.routes.draw do
  apipie
  get 'home/index'
  resources :collections
  resources :products
  resources :orders
  devise_for :users
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get 'profile', action: :profile, controller: 'home'

  namespace :admin do
    root "/admin/dashboard#index"
    resources :dashboard
    resources :products do
      member do
        put :approve
      end
    end
    resources :collections
  end
end
