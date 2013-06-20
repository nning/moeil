source 'https://rubygems.org'

gem 'rails', '~> 3.2.13'

# All database adapters are included for the postfixadmin data import script.
gem 'sqlite3'
gem 'pg'
gem 'mysql'

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
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', platforms: :ruby
  gem 'uglifier', '>= 1.0.3'

  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass', '~> 2.3.1.2'
end

group :development do
  gem 'capistrano'          # Easy deployment
end

group :test do
  gem 'factory_girl_rails'  # Instead of fixtures
  gem 'faker'               # For test data
  gem 'shoulda'             # Cleaner tests
end
