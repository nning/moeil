module ApplicationHelper
  def active_navigation(controller)
    'active' if params[:controller] == controller
  end
end
