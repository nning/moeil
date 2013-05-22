class DomainsController < InheritedResources::Base
  before_filter :authenticate_mailbox!
end
