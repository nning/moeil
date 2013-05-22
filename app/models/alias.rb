class Alias < ActiveRecord::Base

  belongs_to :domain

  attr_accessible :active, :address, :domain, :goto

  def email
    [self.address, self.domain.name].join('@')
  end

end
