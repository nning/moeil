require 'factory_girl_rails'
require 'faker'

ActiveRecord::Base.logger = Logger.new($stdout) unless ENV['DEBUG'].blank?

d = Domain.create name: 'example.org'
d.mailboxes.create username: 'jane.doe', password: 'foobar', admin: true

puts 'Created mailbox jane.doe@example.org (password "foobar") with admin rights.'

(rand(20) + 1).times do
  d = FactoryGirl.create :domain

  begin
    (rand(50) + 1).times { FactoryGirl.create :mailbox, domain: d }
    (rand(20) + 1).times { FactoryGirl.create :alias, domain: d }
  rescue
  end
end
