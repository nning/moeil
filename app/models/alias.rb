class Alias < ActiveRecord::Base
  belongs_to :domain
  attr_accessible :active, :address, :created_at, :domain, :goto, :updated_at
end
