set :application, "instagram-scraper"
set :repo_url, "git@github.com:cupatea/instagram-scraper.git"

set :rbenv_type, :user
set :rbenv_ruby, '2.6.2'

set :passenger_restart_with_touch, true
set :pty, true

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

# Default value for :linked_files is []
set :linked_files, %w[config/database.yml
                      config/sidekiq.yml
                      config/master.key
                      config/sidekiq_schedule.yml]

# Default value for linked_dirs is []
set :linked_dirs, %w[log
                     tmp/pids
                     tmp/cache
                     tmp/sockets
                     vendor/bundle
                     public/system
                     node_modules
                     storage]

set :bundle_binstubs, nil

set :keep_releases, 5

before "deploy:assets:precompile", "deploy:yarn_install"

namespace :deploy do
  desc "Run rake yarn:install"
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install")
      end
    end
  end
end
