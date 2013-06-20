class Admin::VersionsController < AdminController

  inherit_resources

  def index
    @versions = Version.order('created_at desc').page(params[:page]).per(10)
  end

end
