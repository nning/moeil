class Ability
  include CanCan::Ability

  def initialize(mailbox)
    # Define abilities for the passed in mailbox here.
    
    mailbox ||= Mailbox.new # Not logged in
    
    if mailbox.admin?
      can :manage, :all
    elsif mailbox.id
      # Domain
      can :index, Domain do |subject|
        mailbox.manager?
      end
      can [:edit, :update], Domain do |subject|
        subject.permission? :editor, mailbox
      end
      can [:destroy, :permissions], Domain do |subject|
        subject.permission? :owner, mailbox
      end

      # Mailbox and Alias
      [Alias, Mailbox].each do |model|
        can :index, model do |subject|
          mailbox.manager?
        end
        can [:edit, :update], model do |subject|
          subject.domain.permission? :editor, mailbox
        end
        can [:destroy, :permissions], model do |subject|
          subject.domain.permission? :owner, mailbox
        end
      end

      # Version
      can :index, Version do |subject|
        mailbox.manager?
      end
      can :manage, Version do |subject|
        item = subject.item
        item = item.domain unless item.is_a? Domain
        item.permission? :owner, mailbox
      end
    end
  end
end
