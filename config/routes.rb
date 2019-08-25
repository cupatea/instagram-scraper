require "sidekiq/web"
require "sidekiq/cron/web"

if Rails.env.production?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == Rails.application.credentials.sidekiq_username &&
      password == Rails.application.credentials.sidekiq_password
  end
end

Rails.application.routes.draw do
  devise_for :users, skip: :all
  post "/graphql", to: "graphql#execute"
  mount Sidekiq::Web => "/"
end
