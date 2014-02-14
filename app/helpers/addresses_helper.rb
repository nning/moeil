# Shared helpers for Alias and Mailbox models.
module AddressesHelper

  class DomainNotFound < StandardError; end
  class AddressNotFound < StandardError; end

  # A shortcut for Alias or Mailbox Domain.
  def parent
    resource.domain
  end

  # Link to Alias or Mailbox if existing. Argument can be instance of Alias or
  # Mailbox or an E-Mail address as a String.
  def link_to_alias_or_mailbox(email_or_object)
    return nil if email_or_object.blank?

    begin
      email, o = email_and_object(email_or_object)
    rescue Lookup::Error
      return email_or_object
    end

    link_to email, [:edit, :admin, o.domain, o]
  end

  private

  # E-Mail address and Alias or Mailbox object as an Array.
  def email_and_object(email_or_object)
    case email_or_object.class.to_s
      when 'Alias', 'Mailbox'
        o = email_or_object
        email = o.email
      else
        o = Lookup.by_email(email_or_object)
        email = email_or_object
    end

    [email, o]
  end

end
