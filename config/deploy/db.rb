before 'deploy:assets:precompile', 'db:use_sqlite'
 
namespace :db do
  desc 'Use SQLite database for testing in production.'
  task :use_sqlite do
    run "cd #{latest_release}/config && cp database.yml.sqlite database.yml"
  end
end
