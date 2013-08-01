class Admin::AliasesController < AdminController

  inherit_resources

  actions :all, except: :show

  def create
    create! do |success, error|
      success.html { redirect_to admin_domain_aliases_path(resource.domain) }
    end
  end

  def destroy
    destroy! do |success, error|
      success.html { redirect_to admin_domain_aliases_path(resource.domain) }
    end
  end

  def new
    build_resource.domain_id = params[:domain_id]
  end

  def update
    update! do |success, error|
      success.html { redirect_to admin_domain_aliases_path(resource.domain) }
    end
  end

protected

  def collection
    @aliases ||= end_of_association_chain.where(domain_id: params[:domain_id])
  end

end
