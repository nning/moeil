module AliasesAndMailboxesHelper

  def parent
    Domain.where(id: params[:domain_id]).first
  end

  def link_to_alias_or_mailbox(email_or_object)
    return nil if email_or_object.blank?

    if email_or_object.is_a? Alias or email_or_object.is_a? Mailbox
      o = email_or_object
      email = o.email
    else
      username, domain = email_or_object.split('@')
      domain = Domain.where(name: domain).first

      return email_or_object if domain.nil?

      o   = domain.aliases.where(username: username).first
      o ||= domain.mailboxes.where(username: username).first

      return email_or_object if o.nil?

      email = email_or_object
    end

    link_to email, [:edit, :admin, o.domain, o]
  end

  def managable_domains
    Domain.managable current_mailbox
  end

end
