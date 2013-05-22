class MailboxController < InheritedResources::Base
  before_filter :authenticate_mailbox!
end
