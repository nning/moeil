# Shared helpers for Alias and Mailbox models.
module AddressesHelper

  class DomainNotFound < StandardError
  end

  class AddressNotFound < StandardError
  end


  def parent
    Domain.where(id: params[:domain_id]).first
  end

  def link_to_alias_or_mailbox(email_or_object)
    return nil if email_or_object.blank?

    begin
      email, o = email_and_object(email_or_object)
    rescue DomainNotFound, AddressNotFound
      return email_or_object
    end

    link_to email, [:edit, :admin, o.domain, o]
  end


  private

  def email_and_object(email_or_object)
    case email_or_object.class.to_s
      when 'Alias', 'Mailbox'
        o = email_or_object
        email = o.email
      else
        email, o = search_object_by_email(email_or_object)
    end

    [email, o]
  end

  def search_object_by_email(email)
    username, domain = email.split('@')
    domain = Domain.where(name: domain).first

    raise DomainNotFound if domain.nil?

    o   = domain.aliases.where(username: username).first
    o ||= domain.mailboxes.where(username: username).first

    raise AddressNotFound if o.nil?

    [email, o]
  end

end
