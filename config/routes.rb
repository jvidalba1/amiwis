Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'auth/callbacks' }

  root to: "pages#landing"

  get 'pages/landing'

  resources :groups do
    resources :games
    resources :users do
      resources :requests, shallow: true do
        member do
          post "accept"
          post "deny"
        end
      end
    end
  end

  resources :games do
    resources :users do
      resources :inscriptions, shallow: true do
        member do
          post "inactive"
        end
      end
    end
  end

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
