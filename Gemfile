source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 4.2'

gem 'pg', platforms: :ruby
gem 'activerecord-jdbcpostgresql-adapter', platforms: :jruby

gem 'cancan'                              # Authorization
gem 'default_value_for'                   # Default values
gem 'devise'                              # Authentication
gem 'devise-encryptable'
gem 'foreigner'                           # Foreign key constraints
gem 'haml'                                # More beautiful views
gem 'highline'                            # Terminal input in cli scripts
gem 'inherited_resources', '~> 1.7'       # DRY
gem 'jquery-rails'                        # jQuery
gem 'kaminari'                            # Pagination
gem 'paper_trail', '~> 7'                 # Change history
gem 'config'                              # For configuration
gem 'quiet_assets'
gem 'responders', '~> 2'
gem 'searchkick'                          # Efficient search
gem 'simple_form'                         # DRY forms
gem 'turbolinks'                          # Load links with JS
gem 'warden'                              # Rack authentication
gem 'yaml_db'                             # Database dump

group :assets do
  gem 'bootstrap-sass'
  gem 'coffee-rails'
  gem 'therubyracer', platforms: :ruby
  gem 'therubyrhino', platforms: :jruby
  gem 'uglifier'
end

group :development do
  # Convenient deployment
  gem 'capistrano', '~> 3'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv', github: 'capistrano/rbenv'

  # More beautiful exception pages
  # gem 'better_errors', platforms: :ruby
  # gem 'binding_of_caller', platforms: :ruby
  gem 'web-console', '~> 3'

  gem 'rails-erd'                         # Entity/relationship diagram of model
  gem 'brakeman', require: false          # Vulnerability scanner
end

group :development, :test do
  platforms :ruby do
    gem 'sqlite3'
    gem 'mysql2'
  end

  platforms :jruby do
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbcmysql-adapter'
  end
end

group :test do
  gem 'coveralls', require: false        # Test coverage statistics as a service
  gem 'factory_girl_rails'               # Instead of fixtures
  gem 'faker'                            # For test data
  gem 'minitest'                         # Required explicitly in "ruby 2.2.0dev (2014-03-04 trunk 45265)"
  gem 'rake'                             # Travis seems to like this added explicitly
  gem 'shoulda'                          # More beautiful assertions
  gem 'shoulda-matchers', '~> 2.4'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
