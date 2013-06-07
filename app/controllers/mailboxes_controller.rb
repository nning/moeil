class MailboxesController < InheritedResources::Base

  before_filter :require_login

  def resource
    current_mailbox
  end

  def update
    unless current_mailbox.admin?
      [:domain_id, :quota, :username].each do |a|
        params[:mailbox][a] = current_mailbox.send(a)
      end
    end

    update! do |success, error|
      success.html { redirect_to edit_mailbox_path }
    end
  end

private

  def require_login
    redirect_to new_mailbox_session_path unless current_mailbox
  end

end
