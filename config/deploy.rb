require 'bundler/capistrano'
require File.expand_path('../../config/environment',  __FILE__)

hostname = YAML.load_file("#{File.dirname(__FILE__)}/settings.yml")['host']

set :application, Rails.application.class.parent_name.downcase

set :repository, 'https://github.com/nning/moeil.git'
set :deploy_to, '/srv/http/' + hostname
set :shared_children, %w(log tmp/pids)
set :use_sudo, false

default_run_options[:pty] = true

role :app, hostname
role :web, hostname
role :db,  hostname, primary: true

Dir[File.dirname(__FILE__) + '/deploy/*.rb'].each { |f| load f }
