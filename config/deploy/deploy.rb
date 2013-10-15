after 'deploy:update', 'deploy:symlink_secret'
after 'deploy:update', 'deploy:git_version'
after 'deploy:setup', 'deploy:chown'
after 'deploy', 'deploy:cleanup'

before 'deploy:symlink_secret', 'deploy:create_dirs'

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
      run "cd #{release_path} && bundle exec rake secret:replace"
      run "mv #{release_secret} #{shared_secret}"
    end
    
    run "ln -nfs #{shared_secret} #{release_secret}"
  end

  desc 'Set owner of application folders'
  task :chown do
    run "sudo -p 'sudo password: ' chown -R $(whoami):$(whoami) #{deploy_to}"
  end

  desc 'Create necessary directories'
  task :create_dirs do
    run "mkdir -p #{shared_path}/config"
  end

  desc 'Save git version'
  task :git_version do
    run "cd #{release_path} && git log | head -1 | cut -d ' ' -f 2 > app/views/shared/_git_version.html.haml"
  end
end
