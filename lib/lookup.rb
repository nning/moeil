# Comfortable lookup of Aliases or Mailboxes.
module Lookup
  class Error < StandardError; end

  class DomainNotFound < Error; end
  class AddressNotFound < Error; end

  # Search Alias or Mailbox by E-Mail address and return model instance.
  def self.by_email(email)
    username, domain = email.split('@')
    domain = Domain.where(name: domain).first

    raise DomainNotFound if domain.nil?

    o   = domain.aliases.where(username: username).first
    o ||= domain.mailboxes.where(username: username).first

    raise AddressNotFound if o.nil?

    o
  end
end
