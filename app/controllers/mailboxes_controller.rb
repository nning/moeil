class MailboxesController < InheritedResources::Base

  load_and_authorize_resource

  def resource
    current_mailbox
  end

  def update
    update! do |success, error|
      success.html { redirect_to [:edit, :mailbox] }
    end
  end


  private

  def permitted_params
    a = [
      :email,
      :name,
      :password,
      :password_confirmation
    ]

    if current_mailbox.admin?
      a << [
        :active,
        :admin,
        :domain_id,
        :mail_location,
        :quota,
        :username
      ]
    end

    {mailbox: params.require(mailbox: a)}
  end

  def require_login
    redirect_to new_mailbox_session_path unless current_mailbox
  end

end
