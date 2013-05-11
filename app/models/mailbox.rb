class Mailbox < ActiveRecord::Base
  belongs_to :domain
  attr_accessible :active, :maildir, :name, :password, :quota, :username
end
