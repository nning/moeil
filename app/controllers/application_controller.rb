class ApplicationController < ActionController::Base

  check_authorization unless: :devise_controller?

  protect_from_forgery

  def after_sign_in_path_for(resource)
    edit_mailbox_path
  end

  def current_ability
    @current_ability ||= Ability.new current_mailbox
  end

protected

  def user_for_paper_trail
    mailbox_signed_in? ? current_mailbox : 'Unknown'
  end

end
