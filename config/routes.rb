CODE::Application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  devise_for :users, controllers: { omniauth_callbacks: "omniauth" }

  root 'pages#show'

  resources :events, only: [:index]
  resources :jobs, only: [:index]
  resources :organizations
  resources :pages, only: [:show]
end
