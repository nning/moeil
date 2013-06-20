class ApplicationController < ActionController::Base

  protect_from_forgery

  def after_sign_in_path_for(resource)
    edit_mailbox_path
  end

protected

  def user_for_paper_trail
    current_mailbox || 'Unknown'
  end

end
