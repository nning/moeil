module AliasAndMailboxHelper

  def parent
    Domain.where(id: params[:domain_id]).first
  end

  def link_to_alias_or_mailbox(email)
    return nil if email.nil?

    username, domain = email.split('@')
    domain = Domain.where(name: domain).first

    return email if domain.nil?

    o   = domain.aliases.where(username: username).first
    o ||= domain.mailboxes.where(username: username).first

    return email if o.nil?

    link_to email, [:edit, :admin, o.domain, o]
  end

end
