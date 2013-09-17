module DomainHelper
  
  def link_to_domain(domain)
    domain = Domain.where(name: domain).first if domain.is_a? String
    link_to domain.name, [:edit, :admin, domain]
  end

end
