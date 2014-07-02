require 'resolv'

# Make resolving DNS records a little more handy.
module Resolve
  # Resolves A or AAAA record.
  def self.address(domain)
    Resolv::DNS.new
      .getaddress(domain.to_s)
      .to_s
  rescue Resolv::ResolvError
    nil
  end

  # Resolves MX record.
  def self.mx(domain)
    Resolv::DNS.new
      .getresource(domain.to_s, Resolv::DNS::Resource::IN::MX)
      .exchange
      .to_s
  rescue Resolv::ResolvError
    nil
  end
end
