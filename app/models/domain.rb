class Domain < ActiveRecord::Base
  has_many :aliases
  has_many :mailboxes
  attr_accessible :active, :backupmx, :created_at, :description, :name, :updated_at
end
