class Admin::DomainsController < AdminController

  before_filter :authenticate_mailbox!

  inherit_resources

end
