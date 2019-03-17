require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
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
    root "admins/dashboard#index"
    authenticate :admin, ->(a) { a.root? } do
      mount Sidekiq::Web => "admins/sidekiq"
    end
  end
end
