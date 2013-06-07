class AdminController < ApplicationController

  before_filter :admin?

  def admin?
    unless current_mailbox.try(:admin?)
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    end
  end

end
