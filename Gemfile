source 'https://rubygems.org'

gem 'rails', '~> 4.0.0'

# All database adapters are included for the postfixadmin data import script.
platforms :ruby do
  gem 'sqlite3'
  gem 'pg'
  gem 'mysql'
end

platforms :jruby do
  gem 'activerecord-jdbcsqlite3-adapter'
  gem 'activerecord-jdbcpostgresql-adapter'
  gem 'activerecord-jdbcmysql-adapter'
end

gem 'cancan'                             # Authorization
gem 'devise', '~> 3.1.0.rc2'             # Authentication
gem 'devise-encryptable'
gem 'foreigner'                          # Foreign key constraints
gem 'haml'                               # More beautiful views
gem 'highline'                           # Terminal input in cli scripts
gem 'inherited_resources'                # DRY
gem 'jquery-rails'                       # jQuery
gem 'kaminari'                           # Pagination
gem 'paper_trail', github: 'airblade/paper_trail', branch: 'rails4' # Change history
gem 'rails_config'                       # For configuration
gem 'simple_form', github: 'plataformatec/simple_form' # DRY form
gem 'turbolinks'                         # Load links with JS
gem 'yaml_db'                            # Database dump

group :assets do
  gem 'coffee-rails'
  gem 'therubyracer', platforms: :ruby
  gem 'therubyrhino', platforms: :jruby
  gem 'uglifier'

  gem 'sass-rails', github: 'rails/sass-rails' # Less ugly CSS
  gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass'
end

group :development do
  # Convenient deployment
  gem 'capistrano', '~> 3.0.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv', github: 'capistrano/rbenv'
end

group :test do
  gem 'factory_girl_rails'               # Instead of fixtures
  gem 'faker'                            # For test data
  gem 'shoulda'                          # More beautiful assertions
  gem 'shoulda-matchers', '~> 2.4.0.rc1'
end

group :development, :test do
  gem 'rspec-rails', '~>2.0'             # Needed by shoulda
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
