class Ability
  include CanCan::Ability

  def initialize(mailbox)
    # Define abilities for the passed in mailbox here.
    
    mailbox ||= Mailbox.new # Not logged in
    
    if mailbox.admin?
      can { true }
    elsif mailbox.id
      # Domain
      can [:edit, :update], Domain do |subject|
        subject.permission? :editor, mailbox
      end
      can [:destroy, :permissions], Domain do |subject|
        subject.permission? :owner, mailbox
      end
      can [:new, :create], Domain do |subject|
        subject.admin?
      end
      # Mailbox
      can Mailbox do |subject|
        subject.domain.permission? :editor, mailbox
      end
      # Alias
      can Alias do |subject|
        subject.domain.permission? :editor, mailbox
      end
    end
  end
end
