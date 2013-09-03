class Admin::AliasesAndMailboxesController < AdminController

  inherit_resources

  actions :all, except: :show

  def create
    create! do |success, error|
      success.html { redirect_to redirect_path }
    end
  end

  def destroy
    destroy! do |success, error|
      success.html { redirect_to redirect_path }
    end
  end

  def new
    build_resource.domain_id = params[:domain_id]
  end

  def update
    update! do |success, error|
      success.html { redirect_to redirect_path }
    end
  end

protected

  def collection
    @aliases ||= end_of_association_chain.where(domain_id: params[:domain_id])
  end

  def model
    resource.class.to_s.downcase.pluralize
  end

  def redirect_path
    eval "admin_domain_#{model}_path(resource.domain)"
  end

end
