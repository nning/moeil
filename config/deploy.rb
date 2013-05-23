require 'bundler/capistrano'

hostname = 'moeil.orgizm.net'

set :application, 'moeil'

set :repository, 'git://git.orgizm.net/moeil.git'
set :deploy_to, '/srv/http/' + hostname
set :deploy_via, :remote_cache
set :shared_children, %w(log tmp/pids)

role :app, hostname
role :web, hostname
role :db,  hostname, :primary => true

Dir[File.dirname(__FILE__) + '/deploy/*.rb'].each { |f| load f }
