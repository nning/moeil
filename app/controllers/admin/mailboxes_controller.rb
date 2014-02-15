class Admin::MailboxesController < Admin::AddressesController
  load_and_authorize_resource :mailbox, through: :domain
end
