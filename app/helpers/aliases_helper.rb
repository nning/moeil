# Helper for aliases views.
module AliasesHelper
  include AddressesHelper

  # Insert links to existing Aliases or Mailboxes in String list of E-Mail
  # addresses.
  def address_list(string)
    addresses = string.split(',')
    html = []
    
    addresses.each do |a|
      begin
        o = Lookup.by_email(a)
        a = link_to a, [:edit, :admin, o.domain, o]
      rescue Lookup::Error
        a = content_tag :p, a
      end

      html.push a
    end

    html.join.html_safe
  end
end
