class Admin::VersionsController < AdminController

  load_and_authorize_resource

  inherit_resources

  def index
    @versions = Version.order('created_at desc').page(params[:page]).per(10)
  end

  def revert
    @version = Version.find(params[:id])

    if ['update', 'destroy'].include? @version.event
      @version.reify.save!
      redirect_to admin_versions_path, notice: "Reverted #{@version.event}."
    else
      redirect_to admin_versions_path, flash: { error: "Unpossible to revert #{@version.event}." }
    end
  end

end
