Rails.application.routes.draw do
  devise_for :users
  # devise_for :users


  root to: "pages#landing"

  get 'pages/landing'


  resources :groups do
    resources :users do
      resources :requests, shallow: true do
        member do
          post "accept"
          post "deny"
        end
      end

    end
  end

  resources :games
  resources :users
  resources :groups
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
