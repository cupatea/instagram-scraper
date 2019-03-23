require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  root "admins/dashboard#index"
  # Devise for users and admins
  devise_for :users,
             path: "users",
             controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords",
                            confirmations: "users/confirmations", unlocks: "users/unlocks"  },
             path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }

  devise_for :admins,
             path: "admins",
             controllers: { sessions: "admins/sessions", registrations: "admins/registrations", passwords: "admins/passwords",
                            confirmations: "admins/confirmations", unlocks: "admins/unlocks"},
             path_names: { sign_in: "login", sign_out: "logout" }
  # Sidekick for root admin
  authenticated :admin do
    # root "admins/dashboard#index"
    authenticate :admin, ->(a) { a.root? } do
      mount Sidekiq::Web => "admins/sidekiq"
    end
  end
  # Admins routes
  namespace :admins do
    # root "dashboard#index"
    resources :dashboard, only: [:index]
    resources :users, only: [:index, :show, :destroy] do
      member do
        get :toggle_access
        get :confirm
      end
    end
    resources :instagram_users, only: [:index, :show, :destroy]
  end

  # API
  namespace :api, defaults: { format: :json }  do
    namespace :v1 do
      namespace :admins do
        resources :followers_data, only: [:index, :show]
      end
    end
  end
end
