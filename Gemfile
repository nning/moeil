source 'https://rubygems.org'

gem 'rails', '~> 4.0.0'

gem 'pg', platforms: :ruby
gem 'activerecord-jdbcpostgresql-adapter', platforms: :jruby

gem 'cancan'                             # Authorization
gem 'default_value_for'                  # Default values
gem 'devise', '~> 3.1.1'                 # Authentication
gem 'devise-encryptable'
gem 'foreigner'                          # Foreign key constraints
gem 'haml'                               # More beautiful views
gem 'highline'                           # Terminal input in cli scripts
gem 'inherited_resources'                # DRY
gem 'jquery-rails'                       # jQuery
gem 'kaminari'                           # Pagination
gem 'paper_trail', '~> 3.0.0.beta1'      # Change history
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
  gem 'capistrano', '~> 3.0.0'            # Convenient deployment
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv', github: 'capistrano/rbenv'

  gem 'better_errors'                     # More beautiful exception pages
  gem 'binding_of_caller'

  gem 'rails-erd'                         # Entity/relationship diagram of model
  gem 'brakeman', require: false          # Vulnerability scanner
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

# gem 'rspec-rails', '~> 2.0'            # Needed by shoulda
end

group :test do
  gem 'factory_girl_rails'               # Instead of fixtures
  gem 'faker'                            # For test data
  gem 'shoulda'                          # More beautiful assertions
  gem 'shoulda-matchers', '~> 2.4.0'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
