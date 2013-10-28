source 'https://rubygems.org'

gem 'rails', '~> 3.2.15'

gem 'pg', platforms: :ruby
gem 'activerecord-jdbcpostgresql-adapter', platforms: :jruby

gem 'cancan'                        # Authorization
gem 'default_value_for'             # Default values
gem 'devise'                        # Authentication
gem 'devise-encryptable'
gem 'foreigner'                     # Foreign key constraints
gem 'haml'                          # More beautiful views
gem 'highline'                      # For terminal input in command line scripts
gem 'inherited_resources'           # DRY
gem 'jquery-rails'                  # jQuery
gem 'kaminari'                      # Pagination
gem 'paper_trail'                   # Change history
gem 'rails_config'                  # For configuration
gem 'simple_form'                   # DRY form
gem 'yaml_db'                       # Database dump

group :assets do
  gem 'coffee-rails'
  gem 'therubyracer', platforms: :ruby
  gem 'therubyrhino', platforms: :jruby
  gem 'uglifier'

  gem 'sass-rails'
  gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass'
end

group :development do
  # Convenient deployment
  gem 'capistrano', '~> 3.0.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv', github: 'capistrano/rbenv'

  # More beautiful exception pages
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'rails-erd'                   # Entity/relationship diagram of model
  gem 'brakeman', require: false    # Vulnerability scanner
end

group :development, :test do
  platforms :ruby do
    gem 'sqlite3'
    gem 'mysql'
  end

  platforms :jruby do
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbcmysql-adapter'
  end
end

group :test do
  gem 'factory_girl_rails'          # Instead of fixtures
  gem 'faker'                       # For test data
  gem 'rake'                        # Travis seems to like this added explicitly
  gem 'shoulda'                     # Cleaner tests
end
