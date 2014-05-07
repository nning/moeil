# Versioning information.
module About
  # Rails version.
  def self.rails
    'Rails ' + Rails::VERSION::STRING
  end

  # Ruby platform.
  def self.ruby
    RUBY_DESCRIPTION.capitalize.split(' ').first(2).join(' ')
    'Ruby ' + RUBY_VERSION
  end

  # Change time of Rails root.
  def self.last_deploy
    File.ctime Rails.root
  end
end
