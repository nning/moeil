before 'deploy:assets:precompile', 'db:use_pgsql'
after 'db:use_pgsql', 'db:migrate'
 
namespace :db do
  desc 'Use SQLite database in production.'
  task :use_sqlite do
    run "cd #{latest_release}/config && cp database.yml.sqlite3 database.yml"
  end

  desc 'Use PostgreSQL database in production.'
  task :use_pgsql do
    run "cd #{latest_release}/config && cp database.yml.pgsql database.yml"
  end

  desc 'Migrate database.'
  task :migrate do
    run "cd #{latest_release} && RAILS_ENV=production rake db:migrate"
  end
end
