source 'https://rubygems.org'

gem 'rails', '~> 3.2.14'

# All database adapters are included for the postfixadmin data import script.
gem 'sqlite3'
gem 'pg'
gem 'mysql'

gem 'cancan'                # Authorization
gem 'devise'                # Authentication
gem 'devise-encryptable'
gem 'foreigner'             # Foreign key constraints
gem 'haml'                  # More beautiful views
gem 'highline'              # For terminal input in command line scripts
gem 'inherited_resources'   # DRY
gem 'jquery-rails'          # jQuery
gem 'kaminari'              # Pagination
gem 'paper_trail'           # Change history
gem 'rails_config'          # For configuration
gem 'simple_form'           # DRY form
gem 'yaml_db'               # Database dump

group :assets do
  gem 'coffee-rails'
  gem 'therubyracer', platforms: :ruby
  gem 'uglifier'

  gem 'sass-rails'
  gem 'bootstrap-sass'
end

group :development do
  gem 'capistrano'          # Easy deployment
end

group :test do
  gem 'factory_girl_rails'  # Instead of fixtures
  gem 'faker'               # For test data
  gem 'shoulda'             # Cleaner tests
end
