set :stage, :production
server 'moeil.orgizm.net', roles: [:web, :app], user: ENV['USER']
