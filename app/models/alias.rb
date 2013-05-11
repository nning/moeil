class Alias < ActiveRecord::Base
  belongs_to :domain
  attr_accessible :active, :address, :goto
end
