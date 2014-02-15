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
    object = fetch_or_fake_object(version)

    # String representation of object.
    html = object.to_s

    # Link if object is existing.
    if object.persisted?
      url = url_for object.edit_url_array
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

  # Instanciate dummy for version of deleted object.
  def fake_object(version)
    if version.object
      hash = YAML.load(version.object)
    else
      hash = object_changes_to_hash(version)
    end

    object = Object.const_get(version.item_type).new
    object.assign_attributes hash, without_protection: true

    object
  end

  # Fetch object or instanciate dummy if it does not exist.
  def fetch_or_fake_object(version)
    Object.const_get(version.item_type).find(version.item_id)
  rescue ActiveRecord::RecordNotFound
    fake_object version
  end

  # Convert changes YAML to hash just containing the new values.
  def object_changes_to_hash(version)
    hash = {}
    YAML.load(version.object_changes).each do |key, value|
      hash[key] = value.last
    end
    hash
  end
end
