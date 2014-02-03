module VersionsHelper

  include MailboxesHelper

  def icon_for_event(event)
    case event
      when 'create'
        icon :plus
      when 'destroy'
        icon :trash
      when 'update'
        icon :edit
    end
  end

  def link_to_object(version)
    clazz = version.item_type
    id    = version.item_id

    begin
      object = Object.const_get(clazz).find(id)
    rescue ActiveRecord::RecordNotFound
      if version.object
        hash = YAML.load(version.object)
      else
        hash = object_changes_to_hash(version)
      end

      object = Object.const_get(clazz).new
      object.assign_attributes hash
    end

    html = ''
    html << if object.persisted?
      link_to object.to_s, url_for_object(object)
    else
      object.to_s
    end
    html.html_safe
  end

  def summarize_changes(changes)
    return unless changes

    html = ''
    YAML.load(changes).each do |k, v|
      html << content_tag(:p, "#{k}: #{v}")
    end
    html.html_safe
  end


  private

  def url_for_object(object)
    url_for case object.class.to_s
      when 'Domain'
        [:edit, :admin, object]
      when 'Alias'
        [:edit, :admin, object.domain, object]
      when 'Mailbox'
        [:edit, :admin, object.domain, object]
      when 'Permission'
        [:edit, :admin, object.item, object]
    end
  end

  def object_changes_to_hash(version)
    h = {}
    YAML.load(version.object_changes).each do |key, value|
      h[key] = value.last
    end
    h
  end

end
