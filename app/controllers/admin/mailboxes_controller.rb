class Admin::MailboxesController < Admin::AliasesAndMailboxesController

  load_and_authorize_resource :mailbox, through: :domain


  private

  def permitted_params
    params.permit \
      :domain_id,
      mailbox: [
        :active,
        :admin,
        :current_password,
        :domain_id,
        :email,
        :mail_location,
        :name,
        :password,
        :password_confirmation,
        :quota,
        :username
      ]
  end

end
