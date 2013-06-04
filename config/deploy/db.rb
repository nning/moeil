before 'deploy:assets:precompile', 'db:copy_db_config'
after 'db:copy_db_config', 'db:migrate'
 
namespace :db do
  desc 'Copy production database config from home directory of deployment user.'
  task :copy_db_config do
    run "cd #{latest_release}/config && cp ~/database.yml ."
  end

  desc 'Migrate database.'
  task :migrate do
    run "cd #{latest_release} && RAILS_ENV=production rake db:migrate"
  end
end
