before 'deploy:assets:precompile', 'db:use_sqlite'
after 'db:use_sqlite', 'db:migrate'
 
namespace :db do
  desc 'Use SQLite database for testing in production.'
  task :use_sqlite do
    run "cd #{latest_release}/config && cp database.yml.sqlite3 database.yml"
  end

  desc 'Migrate database.'
  task :migrate do
    run "cd #{latest_release} && RAILS_ENV=production rake db:migrate"
  end
end
