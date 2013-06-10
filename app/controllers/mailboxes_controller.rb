class MailboxesController < InheritedResources::Base

  before_filter :assure_logged_in

  def resource
    current_mailbox
  end

  def update
    unless current_mailbox.admin?
      [:domain_id, :quota, :username].each do |a|
        params[:mailbox].delete a
      end
    end

    unless params[:mailbox][:password].blank?
      unless current_mailbox.valid_password? params[:mailbox][:current_password]
        redirect_to edit_mailbox_path, flash: { error: 'Current password is wrong.' }
        return
      end
    end

    params[:mailbox].delete :current_password

    update! do |success, error|
      success.html { redirect_to edit_mailbox_path }
    end
  end

private

  def assure_logged_in
    redirect_to new_mailbox_session_path unless current_mailbox
  end

end
