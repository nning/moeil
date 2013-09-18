class Admin::PermissionsController < AdminController

  inherit_resources
  actions :all, except: :show

  belongs_to :domain

  def create
    build_resource.creator = current_mailbox
    build_resource.subject = Mailbox.find(params[:permission][:subject_id])
    build_resource.save!

    respond_to do |format|
      format.html { redirect_to [:admin, parent, :permissions] }
    end
  end

end
