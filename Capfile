# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rbenv'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir['lib/capistrano/tasks/*.rake'].each { |f| import f }
