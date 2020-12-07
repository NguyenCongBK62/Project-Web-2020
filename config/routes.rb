Rails.application.routes.draw do
  root 'static_page#home'
  devise_for :users
  resources :articles, only: [:index, :show, :create, :destroy]
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
