module ApplicationHelper
  def active_navigation(controller)
    'active' if params[:controller] == controller
  end

  def flash_class(type)
    ({ notice: :info, alert: :warning }[type] or type).to_s
  end

  def link_to_back
    link_to 'javascript:history.back()', class: 'btn' do
      content_tag :i, nil, class: 'icon-arrow-left'
    end
  end

  def link_to_create(path)
    link_to path, class: 'btn' do
      content_tag :i, nil, class: 'icon-plus'
    end
  end
end
