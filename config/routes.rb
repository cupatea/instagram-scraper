require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  # Devise for users and admins
  devise_for :admins,
             path: "admins",
             controllers: { sessions: "admins/sessions",
                            registrations: "admins/registrations",
                            passwords: "admins/passwords",
                            confirmations: "admins/confirmations",
                            unlocks: "admins/unlocks" },
             path_names: { sign_in: "login", sign_out: "logout" }
  # Sidekick for root admin
  authenticated :admin do
    # root "admins/dashboard#index"
    authenticate :admin, ->(a) { a.root? } do
      mount Sidekiq::Web => "admins/sidekiq"
    end
  end
end
