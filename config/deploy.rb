require File.expand_path('../../config/environment',  __FILE__)

set :application, Rails.application.class.parent_name.downcase
set :hostname, Settings.host

set :repo_url, 'https://github.com/nning/moeil.git'
set :scm, :git

set :rbenv_type, :user
set :rbenv_ruby, '2.0.0-p353'

set :deploy_to,  '/srv/http/' + fetch(:hostname)
set :deploy_via, :remote_cache

set :log_level, :info

set :linked_files, %w[config/database.yml config/initializers/secret_token.rb]
set :linked_dirs, %w[bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]

set :keep_releases, 5
