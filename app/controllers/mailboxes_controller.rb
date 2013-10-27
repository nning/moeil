class MailboxesController < InheritedResources::Base

  load_and_authorize_resource

  def resource
    current_mailbox
  end

  def update
    unless current_mailbox.admin?
      %i[active admin domain_id mail_location quota username].each do |a|
        params[:mailbox].delete a
      end
    end

    update! do |success, error|
      success.html { redirect_to [:edit, :mailbox] }
    end
  end

end
