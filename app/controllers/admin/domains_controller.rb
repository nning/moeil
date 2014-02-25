# Domains controller.
class Admin::DomainsController < AdminController
  load_and_authorize_resource

  inherit_resources

  actions :all, except: [:show, :index]

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

  def index
    @domains = Domain.managable current_mailbox
  end

  def update
    super do |success, error|
      success.html { redirect_to [:edit, :admin, resource] }
    end
  end

  private

  def permitted_params
    params.permit \
      domain: [
        :active,
        :backupmx,
        :description,
        :name,
        :quick_access
      ]
  end
end
