# Helper methods available in any view.
module ApplicationHelper
  # Check if controller is currently used. Returns 'active', if it is.
  def active_navigation(controller)
    'active' if params[:controller] == controller
  end

  # Domains, the logged in Mailbox can manage.
  def domains
    @domains ||= Domain.managable current_mailbox
  end

  # Convert flash message type to bootstrap class.
  def flash_class(type)
    ({notice: :info, alert: :warning, error: :danger}[type.to_sym] || type).to_s
  end

  # Link to last visited page.
  def link_to_back
    link_to 'javascript:history.back()', class: 'btn btn-default' do
      icon :arrow_left
    end
  end

  # Link to path as button with plus icon for create actions.
  def link_to_create(path)
    link_to path, class: 'btn btn-default' do
      icon :plus
    end
  end

  # Link to path as button with trash icon for delete actions.
  def link_to_delete(path)
    link_to path, method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger' do
      icon :trash
    end
  end

  # Helper for glyphicon span tags.
  def icon(name, options = {})
    name = name.to_s.gsub(/_/, '-')
    content_tag :span, nil, class: "glyphicon glyphicon-#{name} #{options[:class]}"
  end
end
