# Application controller.
class ApplicationController < ActionController::Base
  check_authorization unless: :devise_controller?

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
#   redirect_to root_url, flash: { alert: exception.message }
    render_404
  end

  # Redirect after sign in.
  def after_sign_in_path_for(resource)
    resource.manager? ? admin_domains_path : edit_mailbox_path
  end

  # Ability for logged in Mailbox.
  def current_ability
    @current_ability ||= Ability.new current_mailbox
  end

  # Show 404 page.
  def render_404
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end

  protected

  # User assigned to version.
  def user_for_paper_trail
    mailbox_signed_in? ? current_mailbox : 'Unknown'
  end
end
