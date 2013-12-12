CODE::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth" }

  root "pages#show"

  resources :events do
    collection do
      get :blog, to: "events#blog"
      get :published, to: "events#published"
      get :unpublished, to: "events#unpublished"
      match :import, to: "events#import", via: [:get, :post]
    end
    member do
      post :publish
      post :unpublish
    end
  end
  resources :feeds do
    collection do
      get :special, to: "feeds#special"
    end
  end
  resources :jobs, only: [:index]
  resources :organizations do
    collection do
      get :published, to: "organizations#published"
      get :unpublished, to: "organizations#unpublished"
    end
    member do
      post :publish
      post :unpublish
    end
  end
  resources :pages, only: [:show]
end
