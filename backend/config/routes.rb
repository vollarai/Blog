require "sidekiq/web"

Rails.application.routes.draw do
  # constraints ->(req) { Session.find_by(id: req.cookie_jar.signed[:session_id])&.user&.roles?(:admin) } do
  #     mount Sidekiq::Web => "/sidekiq"
  # end
  
  resource :session
  resources :passwords, param: :token
  resource :sign_up

  namespace :settings do
    resource :profile, only: [ :show, :update ]
    resource :password, only: [ :show, :update ]
    resource :user, only: [ :show, :destroy ]
    resource :email, only: [ :show, :update ]
  end

  resource :profile, only: [ :show, :update ]

  root "posts#index"

  resources :posts, only: [ :index, :show ] do
    member { get :pdf }
    resources :comments, only: [ :index, :create, :destroy ]
  end

  namespace :blog do
    resources :users, only: [ :index, :show, :edit, :update, :destroy ]
    resources :images, only: [ :destroy ]
    resources :pdfs, only: [:index, :show], controller: "pdf"
    resources :posts do
      resources :post_pdfs, only: [:index, :create], controller: "pdf"
    end

    root to: redirect("/blog/posts")
  end

  namespace :email do
    resources :confirmations, param: :token, only: [ :show ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
