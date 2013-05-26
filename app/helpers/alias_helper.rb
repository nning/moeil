module AliasHelper
  def address_list(string)
    addresses = string.split(',')
    html = []
    
    addresses.each do |a|
      u = a.split('@').first
      m = Mailbox.joins(:domain).where(username: u).first

      unless m.nil?
        a = link_to a, edit_admin_domain_mailbox_path(m.domain, m)
      end

      a = content_tag :p, a

      html.push a
    end

    html.join.html_safe
  end
end
