require 'factory_girl_rails'
require 'faker'

def rand5; rand(5) + 1; end

ActiveRecord::Base.logger = Logger.new($stdout) unless ENV['DEBUG'].blank?

d, p  = Domain.create(name: 'example.org'), 'whatever'
alice = d.mailboxes.create username: 'alice', password: p, admin: true
bob   = d.mailboxes.create username: 'bob',   password: p
carol = d.mailboxes.create username: 'carol', password: p
dan   = d.mailboxes.create username: 'dan',   password: p

d.catch_all_address = alice.email
d.save!

puts <<O
Created mailboxes
  alice@example.org with admin rights,
  bob@example.org as owner of some domains,
  carol@example.org as editor of some domains,
  dan@example.org without special rights
  (all with password "#{p}")
O

rand5.times do
  d = FactoryGirl.create :domain

  begin
    rand5.times { FactoryGirl.create :mailbox, domain: d }
    rand5.times { FactoryGirl.create :alias, domain: d }
  rescue
  end
end

Domain.last(2).each do |d|
  d.permissions.create subject: bob,   role: 'owner'
  d.permissions.create subject: carol, role: 'editor'
end
