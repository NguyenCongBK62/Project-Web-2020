Rails.application.routes.draw do
  root 'static_page#home'
  devise_for :users
  resources :articles
  resources :users, only: [:index, :show]
  resources :articles do
    resources :likes, only: [:create, :destroy], shallow: true
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
