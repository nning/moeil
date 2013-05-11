class Mailbox < ActiveRecord::Base
  belongs_to :domain
  attr_accessible :active, :created_at, :mail_location, :name, :password, :quota, :updated_at, :username
end
