class AdminController < ApplicationController

  before_filter :access?

private

  def access?
    if current_mailbox.nil? || !current_mailbox.manager?
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found and return
    end
  end

end
