class Alias < ActiveRecord::Base

  belongs_to :domain

  attr_accessible :active, :address, :domain, :goto

  def email
    [self.address, self.domain.name].join('@')
  end

  def goto_mailbox
    Mailbox.joins(:domain).where(username: goto_username).first
  end

  def goto_username
    goto.split('@').first
  end

end
