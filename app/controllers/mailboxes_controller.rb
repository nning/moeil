class MailboxesController < InheritedResources::Base

  before_filter :authenticate_mailbox!

  def destroy
    destroy! do |format|
      format.html { redirect_to domain_mailboxes_path(resource.domain) }
    end
  end

  def show
    redirect_to edit_domain_mailbox_path(resource.domain, resource)
  end

  def update
    update! do |success, error|
      success.html { redirect_to edit_domain_mailbox_path(resource.domain, resource) }
    end
  end

protected

  def collection
    @mailboxes ||= end_of_association_chain.where(domain_id: params[:domain_id])
  end

end
