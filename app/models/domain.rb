class Domain < ActiveRecord::Base
  has_many :aliases
  has_many :mailboxes
  attr_accessible :active, :backupmx, :description, :name
end
