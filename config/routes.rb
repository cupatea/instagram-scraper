require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  # Devise for users and admins
  devise_for :admins,
             path: "admins",
             controllers: { sessions: "admins/sessions",
                            passwords: "admins/passwords",
                            confirmations: "admins/confirmations" },
             path_names: { sign_in: "login",
                           sign_out: "logout" }

  devise_for :users,
             path: "users",
             controllers: { sessions: "users/sessions",
                            registrations: "users/registrations",
                            passwords: "users/passwords",
                            confirmations: "users/confirmations",
                            unlocks: "users/unlocks" },
             path_names: { sign_in: "login",
                           sign_out: "logout",
                           sign_up: "register" }
  # Sidekick for root admin
  authenticated :admin do
    authenticate :admin, ->(a) { a.root? } do
      mount Sidekiq::Web => "/"
    end
  end
end
