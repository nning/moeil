source 'https://rubygems.org'

gem 'rails', '~> 4.0.0'

# All database adapters are included for the postfixadmin data import script.
gem 'sqlite3'
gem 'pg'
gem 'mysql'

gem 'bootstrap-sass', '~> 2.3.1.2'    # CSS framework
gem 'coffee-rails'                    # Less ugly JS
gem 'devise'                          # Authentication
gem 'devise-encryptable'
gem 'foreigner'                       # Foreign key constraints
gem 'haml'                            # More beautiful views
gem 'highline'                        # Terminal input in cli scripts
gem 'inherited_resources'             # DRY
gem 'jquery-rails'                    # jQuery
gem 'kaminari'                        # Pagination
gem 'paper_trail', git: 'git://github.com/airblade/paper_trail.git', branch: 'rails4' # Change history
gem 'protected_attributes'            # attr_accessible
gem 'rails_config'                    # For configuration
gem 'sass-rails', git: 'git://github.com/rails/sass-rails.git' # Less ugly CSS
gem 'simple_form', git: 'git://github.com/plataformatec/simple_form.git' # DRY form
gem 'therubyracer', platforms: :ruby  # JS VM for assets
gem 'uglifier', '>= 1.0.3'            # Compress JS
gem 'yaml_db'                         # Database dump

group :development do
  gem 'capistrano'                    # Easy deployment
end

group :test do
  gem 'factory_girl_rails'            # Instead of fixtures
  gem 'faker'                         # For test data
  #gem 'shoulda', git: 'git://github.com/thoughtbot/shoulda.git' # Cleaner tests
  #gem 'shoulda-matchers', git: 'git://github.com/thoughtbot/shoulda-matchers.git'
  gem 'shoulda'
end
