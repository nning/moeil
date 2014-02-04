set :stage, :production
server fetch(:hostname), roles: [:web, :app, :db], user: ENV['USER']
