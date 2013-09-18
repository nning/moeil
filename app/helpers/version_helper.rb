module VersionHelper

  include MailboxHelper

  def link_to_object(version)
    clazz = version.item_type
    id    = version.item_id

    begin
      object = Object.const_get(clazz).find(id)
    rescue ActiveRecord::RecordNotFound
      if version.object
        object = Object.const_get(clazz).new
        object.assign_attributes \
          YAML.load(version.object),
          without_protection: true
      else
        return ''
      end
    end

    html = ''
    html << if object.persisted?
      link_to object.to_s, url_for_object(object)
    else
      object.to_s if object
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

end
