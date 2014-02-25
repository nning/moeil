ENV['RAILS_ENV'] = 'test'

require 'coveralls'
Coveralls.wear!

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActionController::TestCase
  include Devise::TestHelpers
end
