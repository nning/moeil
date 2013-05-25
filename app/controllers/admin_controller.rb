class AdminController < ApplicationController

  before_filter :admin?

  def admin?
    raise ActiveRecord::RecordNotFound unless current_mailbox.try(:admin?)
  end

end
