Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :sign_up

  namespace :settings do
    resource :profile, only: [ :show, :update ]
    resource :password, only: [ :show, :update ]
  end

  resource :profile, only: [ :show, :update ]

  root "posts#index"

  resources :posts, only: [ :index, :show ] do
    member { get :pdf }
    resources :comments, only: [ :create, :destroy ]
  end

  namespace :blog do
    resources :posts
    resources :users
    resources :images, only: [ :destroy ]

    root to: redirect("/blog/posts")
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
