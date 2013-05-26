class Admin::AliasesController < AdminController

  inherit_resources

  before_filter :authenticate_mailbox!

  def destroy
    destroy! do |success, error|
      success.html { redirect_to admin_domain_aliases_path(resource.domain) }
    end
  end

protected

  def collection
    @mailboxes ||= end_of_association_chain.where(domain_id: params[:domain_id])
  end

end
