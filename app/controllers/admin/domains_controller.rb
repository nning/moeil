class Admin::DomainsController < AdminController

  inherit_resources

  #before_filter :authenticate_mailbox!

  def create
    create! do |success, error|
      success.html { redirect_to admin_domains_path }
    end
  end

  def update
    update! do |success, error|
      success.html { redirect_to edit_admin_domain_path(resource) }
    end
  end

end
