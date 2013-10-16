set :stage, :production
server fetch(:hostname), roles: [:web, :app], user: ENV['USER']
