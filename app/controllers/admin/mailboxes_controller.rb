class Admin::MailboxesController < Admin::AliasesAndMailboxesController

  load_and_authorize_resource :mailbox, through: :domain

end
