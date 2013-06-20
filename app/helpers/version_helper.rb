module VersionHelper
  
  def link_to_object(clazz, id)
    object = Object.const_get(clazz).find(id)

    case clazz
      when 'Domain'
        text = object.name
        url = edit_admin_domain_path(object.id)
      when 'Alias'
        text = object.email
        url = edit_admin_domain_alias_path(object.domain.id, object.id)
      when 'Mailbox'
        text = object.email
        url = edit_admin_domain_mailbox_path(object.domain.id, object.id)
    end

    html = ''
    html << link_to(text, url)
    html.html_safe
  end

  def link_to_user(id)
    return unless id

    user = Mailbox.find(id)
    
    html = ''
    html << link_to(user.email, edit_admin_domain_mailbox_path(user.domain.id, user.id))
    html.html_safe
  end

  def summarize_changes(changes)
    html = ''
    YAML.load(changes).each do |k, v|
      html << content_tag(:p, "#{k}: #{v}")
    end
    html.html_safe
  end

end
