source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'rails', github: "rails/rails"

# scraping tools
gem 'httparty'
gem 'nokogiri'

gem 'webpacker'
gem 'pg'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'mutations'
gem 'awesome_print'
gem 'redis-namespace'
gem 'devise'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails'
gem 'puma', '~> 3.11'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 4.0'
gem 'capistrano-rails', group: :development
gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  gem "capistrano",         require: false
  gem "capistrano-rbenv",   require: false
  gem "capistrano-rails",   require: false
  gem "capistrano-bundler", require: false
  gem "capistrano3-puma",   require: false
  gem "capistrano-yarn",    require: false
  gem "capistrano-sidekiq", require: false
  gem "capistrano-npm",     require: false

  gem 'web-console', github: 'rails/web-console'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
