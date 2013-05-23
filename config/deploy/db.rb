before 'deploy:setup', 'db:configure'
after 'deploy:update_code', 'db:symlink'
 
namespace :db do
  desc 'Create database yaml in shared path.'
  task :configure do
    db_config = <<-EOF
      base: &base
        adapter: sqlite3
        pool: 5
        timeout: 5000
       
      development:
        database: #{application}_development
        <<: *base
       
      test:
        database: #{application}_test
        <<: *base
       
      production:
        database: #{application}_production
        <<: *base
    EOF
 
    run "mkdir -p #{shared_path}/config"
    put db_config, "#{shared_path}/config/database.yml"
  end
 
  desc 'Create symlink for database.yml.'
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end
end
