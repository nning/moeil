# CanCan ability definitions.
class Ability

  include CanCan::Ability

  def initialize(mailbox)
    # Define abilities for the passed in mailbox here.
    
    mailbox ||= Mailbox.new # Not logged in
    
    if mailbox.admin?
      can :manage, :all
    elsif mailbox.id
      # Domain
      can [:read, :update], Domain do |subject|
        subject.permission? :editor, mailbox
      end
      can :destroy, Domain do |subject|
        subject.permission? :owner, mailbox
      end

      # Mailbox and Alias
      [Alias, Mailbox].each do |model|
        can :index, model
        can :manage, model do |subject|
          subject.domain.permission? :editor, mailbox
        end
      end

      # Permission
      can :index, Permission
      can :manage, Permission do |subject|
        subject.item.permission? :owner, mailbox
      end
    end
  end

end
