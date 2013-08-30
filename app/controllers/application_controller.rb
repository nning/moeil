class ApplicationController < ActionController::Base

  protect_from_forgery

  def after_sign_in_path_for(resource)
    resource.admin ? admin_domains_path : edit_mailbox_path
  end

protected

  def user_for_paper_trail
    mailbox_signed_in? ? current_mailbox : 'Unknown'
  end

end
