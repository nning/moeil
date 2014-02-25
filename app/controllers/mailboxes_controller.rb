# Mailboxes controller.
class MailboxesController < InheritedResources::Base
  load_and_authorize_resource

  # Work-around for something, I did not understand.
  def resource
    current_mailbox
  end

  # Update Mailbox.
  def update
    update! do |success, error|
      success.html { redirect_to [:edit, :mailbox] }
    end
  end

  private

  def permitted_params
    a = Mailbox::PARAMS
    a = Mailbox::PARAMS_ADMIN if current_mailbox.admin?

    params.permit mailbox: a
  end

  def require_login
    redirect_to [:new, :mailbox_session] unless current_mailbox
  end
end
