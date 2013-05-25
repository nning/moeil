class MailboxesController < InheritedResources::Base

  def resource
    current_mailbox
  end

  def update
    update! do |success, error|
      success.html { redirect_to edit_mailbox_path }
    end
  end

end
