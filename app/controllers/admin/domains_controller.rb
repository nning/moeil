class Admin::DomainsController < AdminController

  before_filter :authenticate_mailbox!

  inherit_resources

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
