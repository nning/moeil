def create_and_sign_in_mailbox
  @mailbox = FactoryGirl.create :mailbox, admin: true
  @domain_id = @mailbox.domain_id
  sign_in @mailbox
end
