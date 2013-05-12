#
# Rake Task for replacing the secret token in
# config/initializers/secret_token.rb
#
namespace :secret do
  desc 'Replace the secure secret key in config/initializers/secret_token.rb'
  task :replace do
    secret = SecureRandom.hex(128)
    path = File.join(Rails.root, 'config', 'initializers', 'secret_token.rb')

    File.open(path, 'w') do |f|
      f.write "Moeil::Application.config.secret_token = '#{secret}'"
    end
  end
end
