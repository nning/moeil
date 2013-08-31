source 'https://rubygems.org'

gem 'rails', '~> 4.0.0'

# All database adapters are included for the postfixadmin data import script.
gem 'sqlite3'
gem 'pg'
gem 'mysql'

gem 'bootstrap-sass', '~> 2.3.2.1'       # CSS framework
gem 'coffee-rails'                       # Less ugly JS
gem 'devise', '~> 3.1.0.rc2'
gem 'devise-encryptable'
gem 'foreigner'                          # Foreign key constraints
gem 'haml'                               # More beautiful views
gem 'highline'                           # Terminal input in cli scripts
gem 'inherited_resources'                # DRY
gem 'jquery-rails'                       # jQuery
gem 'kaminari'                           # Pagination
gem 'paper_trail', git: 'git://github.com/airblade/paper_trail.git', branch: 'rails4' # Change history
gem 'rails_config'                       # For configuration
gem 'sass-rails', git: 'git://github.com/rails/sass-rails.git' # Less ugly CSS
gem 'simple_form', git: 'git://github.com/plataformatec/simple_form.git' # DRY form
gem 'therubyracer', platforms: :ruby     # JS VM for assets
gem 'turbolinks'                         # Load links with JS
gem 'uglifier', '>= 1.0.3'               # Compress JS
gem 'yaml_db'                            # Database dump

group :development do
  gem 'capistrano'                       # Easy deployment
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
