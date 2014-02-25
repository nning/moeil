# Permissions controller.
class Admin::PermissionsController < AdminController
  inherit_resources
  actions :all, except: :show

  belongs_to :domain

  load_and_authorize_resource :domain
  load_and_authorize_resource :permission, through: :domain

  # Create new permission.
  def create
    build_resource.creator = current_mailbox
    build_resource.subject = Mailbox.find(params[:permission][:subject_id])
    build_resource.save!

    super do |success|
      success.html { redirect_to collection_url }
    end
  rescue
    redirect_to [:new, :admin, parent, :permission], flash: { error: 'Permission already existing.' }
  end

  private

  def permitted_params
    params.permit \
      permission: [
        :role,
        :subject,
        :subject_id,
        :subject_type
      ]
  end
end
