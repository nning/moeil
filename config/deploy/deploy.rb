after 'deploy:update', 'deploy:symlink_secret'
after 'deploy:setup', 'deploy:chown'
after 'deploy', 'deploy:cleanup'

namespace :deploy do
  desc 'Restart Application'
  task :restart, roles: :app, except: { no_release: true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc 'Moves and replaces the secret-token if missing in shared directory'
  task :symlink_secret, roles: :app, except: { no_release: true } do 
    filename       = 'secret_token.rb'
    release_secret = "#{release_path}/config/initializers/#{filename}"
    shared_secret  = "#{shared_path}/config/#{filename}"
    
    if capture("[ -f #{shared_secret} ] || echo missing").start_with?('missing')
      rake_command 'secret:replace'
      run "mv #{release_secret} #{shared_secret}"
    end
    
    run "ln -nfs #{shared_secret} #{release_secret}"
  end

  desc 'Set owner of application folders'
  task :chown do
    run "sudo -p 'sudo password: ' chown -R $(whoami):$(whoami) #{deploy_to}"
  end
end
