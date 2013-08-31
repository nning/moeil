require 'factory_girl_rails'
require 'faker'

def rand5; rand(5) + 1; end

ActiveRecord::Base.logger = Logger.new($stdout) unless ENV['DEBUG'].blank?

d, p  = Domain.create(name: 'example.org'), 'foobar'
alice = d.mailboxes.create username: 'alice', password: p, admin: true
bob   = d.mailboxes.create username: 'bob',   password: p
carol = d.mailboxes.create username: 'carol', password: p
dan   = d.mailboxes.create username: 'dan',   password: p

puts <<O
Created mailboxes
  alice@example.org with admin rights,
  bob@example.org as owner of some domains,
  carol@example.org as editor of some domains,
  dan@example.org without special rights
  (all with password "foobar")
O

rand5.times do
  d = FactoryGirl.create :domain

  begin
    rand5.times { FactoryGirl.create :mailbox, domain: d }
    rand5.times { FactoryGirl.create :alias, domain: d }
  rescue
  end
end
