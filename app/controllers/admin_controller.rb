class AdminController < ApplicationController

  authorize_resource

  before_filter :access?

private

  def access?
    render_404 and return if current_mailbox.nil? || !current_mailbox.manager?
  end

end
