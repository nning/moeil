# Shared code for all admin controllers.
class AdminController < ApplicationController
  authorize_resource unless: :no_cancan?

  before_filter :access?

  private

  # Show 404 if no access to admin namespace.
  def access?
    render_404 and return if current_mailbox.nil? || !current_mailbox.manager?
  end

  # Determine, if cancan resource loading is necessary.
  def no_cancan?
    params[:controller] == 'admin/searches'
  end
end
