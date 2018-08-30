Rails.application.routes.draw do
  devise_for :users
  # devise_for :users


  root to: "pages#landing"

  get 'pages/landing'

  resources :groups
  resources :games
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
