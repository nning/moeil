module MailboxHelper
  
  include AliasAndMailboxHelper

  def link_to_mailbox(id)
    return unless id

    m = Mailbox.find(id)
    
    html = ''
    html << link_to(m, [:edit, :admin, m.domain, m])
    html.html_safe
  end

end
