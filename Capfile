# Load DSL and set up stages
require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/rbenv"
require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/puma'
install_plugin Capistrano::Puma
require "capistrano/sidekiq"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
