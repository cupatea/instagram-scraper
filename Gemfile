source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'rails', github: "rails/rails"

gem 'webpacker'
gem 'pg'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'puma', '~> 3.11'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 4.0'
gem 'capistrano-rails', group: :development
gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  gem 'web-console', github: 'rails/web-console'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
