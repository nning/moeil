# Helper for versions views.
module VersionsHelper
  include MailboxesHelper

  # Icons for version events.
  def icon_for_event(event)
    case event
    when 'create'
      icon :plus
    when 'destroy'
      icon :trash
    when 'update'
      icon :edit
    else
      raise "No icon for event '#{event}'."
    end
  end

  # Link to object references in version or String representation.
  def link_to_object(version)
    clazz = version.item_type
    id    = version.item_id

    # Fetch object or instanciate dummy if it does not exist.
    begin
      object = Object.const_get(clazz).find(id)
    rescue ActiveRecord::RecordNotFound
      if version.object
        hash = YAML.load(version.object)
      else
        hash = object_changes_to_hash(version)
      end

      object = Object.const_get(clazz).new
      object.assign_attributes hash, without_protection: true
    end

    # String representation of object.
    html = object.to_s

    # Link if object is existing.
    if object.persisted?
      url = url_for_object(object)
      html = link_to object.to_s, url if url
    end

    html.html_safe
  end

  # Convert changes of version to html summary.
  def summarize_changes(changes)
    return unless changes

    html = ''
    YAML.load(changes).each do |k, v|
      html << content_tag(:p, "#{k}: #{v}")
    end
    html.html_safe
  end

  private

  # URL for link to object referenced by version.
  def url_for_object(object)
    array = case object.class.to_s
    when 'Domain'
      [:edit, :admin, object]
    when 'Alias'
      [:edit, :admin, object.domain, object]
    when 'Mailbox'
      [:edit, :admin, object.domain, object]
    when 'Permission'
      if object.item
        [:edit, :admin, object.item, object]
      else
        return nil
      end
    else
      raise "No URL for object class '#{object.class.to_s}'."
    end

    url_for array
  end

  # Convert changes YAML to hash just containing the new values.
  def object_changes_to_hash(version)
    h = {}
    YAML.load(version.object_changes).each do |key, value|
      h[key] = value.last
    end
    h
  end
end
