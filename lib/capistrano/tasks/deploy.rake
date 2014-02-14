namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles :app, in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after 'deploy:publishing', 'deploy:restart'
  after :finishing, 'deploy:cleanup'

end
