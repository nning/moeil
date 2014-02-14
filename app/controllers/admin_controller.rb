# Shared code for all admin controllers.
class AdminController < ApplicationController

  authorize_resource

  before_filter :access?

  private

  # Show 404 if no access to admin namespace.
  def access?
    render_404 and return if current_mailbox.nil? || !current_mailbox.manager?
  end

end
