# Mailboxes controller.
class Admin::MailboxesController < Admin::AddressesController
  load_and_authorize_resource :mailbox, through: :domain

  private

  def permitted_params
    params.permit :domain_id, mailbox: Mailbox::PARAMS_ADMIN
  end
end
