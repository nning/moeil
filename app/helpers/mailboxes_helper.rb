# Helper for mailboxes views.
module MailboxesHelper
  include AddressesHelper

  # Link to edit action of Mailbox by id.
  def link_to_mailbox(id)
    return unless id
    m = Mailbox.find(id)
    link_to(m, [:edit, :admin, m.domain, m]).html_safe
  end
end
