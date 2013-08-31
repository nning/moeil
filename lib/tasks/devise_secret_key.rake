#
# Rake Task for replacing the devise secret key in
# config/initializers/devise.rb
#
namespace :devise do
  namespace :secret do
    desc 'Replace the devise secret key in config/initializers/devise.rb.'
    task :replace do
      secret = SecureRandom.hex(64)
      path = File.join(Rails.root, 'config', 'initializers', 'devise.rb')

      contents = File.read path
      contents.gsub! /secret_key\ =\ .*/, "secret_key = '#{secret}'"

      File.open(path, 'w') do |f|
        f.write contents
      end
    end
  end
end
