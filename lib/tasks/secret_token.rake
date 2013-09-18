#
# Rake Task for replacing the secret token in
# config/initializers/secret_token.rb
#
namespace :secret do
  desc 'Replace the secure secret key in config/initializers/secret_token.rb.'
  task :replace do
    secret1 = SecureRandom.hex(128)
    secret2 = SecureRandom.hex(128)

    path = File.join(Rails.root, 'config', 'initializers', 'secret_token.rb')

    File.open(path, 'w') do |f|
      f.puts <<EOF
Moeil::Application.config.secret_token = '#{secret1}'
Moeil::Application.config.secret_key_base = Moeil::Application.config.secret_token

Devise.setup do |config|
  config.secret_key = '#{secret2}'
end
EOF
    end
  end
end
