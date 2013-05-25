class Admin::MailboxesController < AdminController

  inherit_resources

  before_filter :authenticate_mailbox!

  def destroy
    destroy! do |success, error|
      format.html { redirect_to admin_domain_mailboxes_path(resource.domain) }
    end
  end

  def update
    update! do |success, error|
      success.html { redirect_to edit_admin_domain_mailbox_path(resource.domain, resource) }
    end
  end

protected

  def collection
    @mailboxes ||= end_of_association_chain.where(domain_id: params[:domain_id])
  end

end
