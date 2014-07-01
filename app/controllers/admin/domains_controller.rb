# Domains controller.
class Admin::DomainsController < AdminController
  load_and_authorize_resource

  inherit_resources

  actions :all, except: [:show, :index]

  # Check if MX records on all managable Domains and redirect to index.
  def check_mx_records
    Domain.managable(current_mailbox).all.map(&:update_mx_set!)
    redirect_to [:admin, :domains]
  end

  # Create Domain and redirect to index.
  def create
    super do |success, error|
      success.html { redirect_to collection_url }
    end
  end

# TODO What happens, if a admin deletes his own domain?
#      Currently he would be logged out and see a 404.
=begin
  def destroy
    if params[:id] == current_mailbox.try(:domain).try(:id)
      flash[:error] = 'You can not delete the domain of your mailbox.'
      redirect_to admin_domains_path
    else
      destroy!
    end
  end
=end

  # Return only managable domains.
  def index
    @domains = Domain.managable current_mailbox
  end

  # Update Domain and redirect to edit form.
  def update
    super do |success, error|
      success.html { redirect_to [:edit, :admin, resource] }
    end
  end
end
