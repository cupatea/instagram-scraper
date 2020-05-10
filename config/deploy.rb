set :application, "instagram-scraper"
set :repo_url, "git@github.com:cupatea/instagram-scraper.git"

set :rbenv_type, :user
set :rbenv_ruby, '2.7.1'

set :passenger_restart_with_touch, true
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w[config/database.yml
                      config/sidekiq.yml
                      config/master.key
                      config/credentials/production.key
                      config/sidekiq_schedule.yml
                      client/.env]

# Default value for linked_dirs is []
set :linked_dirs, %w[log
                     tmp/pids
                     tmp/cache
                     tmp/sockets
                     vendor/bundle
                     public/system
                     client/node_modules
                     storage]

set :bundle_binstubs, nil
set :keep_releases, 5
set :nvm_type, :user
set :nvm_node, 'v8.11.1'
set :nvm_map_bins, %w[node npm]

before "deploy:migrate", "deploy:npm_build"

namespace :deploy do
  desc "Deploy frontend"
  task :npm_build do
    on roles(:web) do
      execute("cd #{release_path}/&& cd client && npm install --silent && npm run --silent build")
    end
  end
end
