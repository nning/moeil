class MailboxesController < InheritedResources::Base

  before_filter :authenticate_mailbox!

  def destroy
    destroy! do |format|
      format.html { redirect_to domain_mailboxes_path(current_mailbox.domain) }
    end
  end

  def update
    update! do |format|
      format.html { redirect_to edit_domain_mailbox_path(current_mailbox.domain, current_mailbox) }
    end
  end

  protected

    def collection
      @mailboxes ||= end_of_association_chain.where(domain_id: params[:domain_id])
    end

end
