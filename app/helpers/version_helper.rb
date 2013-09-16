module VersionHelper
  
  def link_to_object(version)
    clazz = version.item_type
    id    = version.item_id

    begin
      object = Object.const_get(clazz).find(id)
    rescue ActiveRecord::RecordNotFound
      return alternative_name(version)
    end

    text, url = get_text_and_url(clazz, object)

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
    return unless changes

    html = ''
    YAML.load(changes).each do |k, v|
      html << content_tag(:p, "#{k}: #{v}")
    end
    html.html_safe
  end

private

  # TODO Better handling of domain deletion.
  def alternative_name(version)
    if version.object
      hash   = YAML.load(version.object)
      domain = Domain.where(id: hash['domain_id']).first
      domain = domain ? domain.name : 'unknown'

      return [hash['username'], domain].join('@')
    end

    hash     = YAML.load(version.object_changes)

    username = hash['username'].try(:last)

    domain   = hash['domain_id'].try(:last)
    domain   = domain.nil? ? 'unknown' : Domain.find(domain).name

    return "Cath-All alias for #{domain}" if username.nil?
    return [username, domain].join('@')
  end

  def get_text_and_url(clazz, object)
    case clazz
      when 'Domain'
        text = object.name
        url = edit_admin_domain_path(object.id)
      when 'Alias'
        text = if object.username
          object.email
        else
          "Catch-All alias for #{object.domain.name}"
        end
        url = edit_admin_domain_alias_path(object.domain.id, object.id)
      when 'Mailbox'
        text = object.email
        url = edit_admin_domain_mailbox_path(object.domain.id, object.id)
    end

    [text, url]
  end

end
