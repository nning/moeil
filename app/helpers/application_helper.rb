module ApplicationHelper
  def active_navigation(controller)
    'active' if params[:controller] == controller
  end

  def flash_class(type)
    ({ notice: :info, alert: :warning }[type] or type).to_s
  end
end
