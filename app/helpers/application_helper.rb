module ApplicationHelper

  def active_navigation(controller)
    'active' if params[:controller] == controller
  end

  def flash_class(type)
    ({ notice: :info, alert: :warning }[type] or type).to_s
  end

  def link_to_back
    link_to 'javascript:history.back()', class: 'btn btn-default' do
      icon :arrow_left
    end
  end

  def link_to_create(path)
    link_to path, class: 'btn btn-default' do
      icon :plus
    end
  end

  def link_to_delete(path)
    link_to path, method: :delete, confirm: 'Are you sure?', class: 'btn btn-danger' do
      icon :trash
    end
  end

  def icon(name)
    name = name.to_s.gsub /_/, '-'
    content_tag :span, nil, class: "glyphicon glyphicon-#{name}"
  end

end
