# DevelopmentLogin controller for quick login in development environment.
class DevelopmentLoginController < ApplicationController
  skip_authorization_check

  # Change logged in Mailbox in development environment.
  def update
    render_404 and return unless Rails.env.development?

    mailbox = Mailbox.find(params[:development_login][:mailbox_id])

    sign_in mailbox
    redirect_to after_sign_in_path_for mailbox
  end
end
