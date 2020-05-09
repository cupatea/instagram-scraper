source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0', '>= 6.0.3'

# scraping tools
gem 'httparty'
gem 'nokogiri'
gem "webdrivers"
gem "capybara"

gem 'pg'
gem 'sidekiq', '~> 5.1'
gem 'sidekiq-cron'
gem 'mutations'
gem 'awesome_print'
gem 'redis-namespace'
gem 'devise'
gem 'kaminari'
gem 'puma'
gem 'redis'
gem 'bootsnap', require: false
gem 'graphql'
gem 'devise_token_auth'
gem 'graphql-pundit'
gem 'rack-cors'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'graphiql-rails'
  gem 'pry'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'foreman'
  gem 'letter_opener'
end

group :deployment do
  gem "capistrano",           require: false
  gem "capistrano-rbenv",     require: false
  gem "capistrano-rails",     require: false
  gem "capistrano-bundler",   require: false
  gem "capistrano-passenger", require: false
  gem "capistrano-yarn",      require: false
  gem "capistrano-sidekiq",   require: false
  gem "capistrano-npm",       require: false
end
