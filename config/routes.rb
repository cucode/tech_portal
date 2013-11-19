CODE::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth" }

  root "pages#show"

  resources :events, only: [:index] do
    collection do
      get :published, to: "events#published"
      get :unpublished, to: "events#unpublished"
      match :import, to: "events#import", via: [:get, :post]
    end
    member do
      post :publish
      post :unpublish
    end
  end
  resources :jobs, only: [:index]
  resources :organizations
  resources :pages, only: [:show]
end
