class Ability
  include CanCan::Ability

  def initialize(mailbox)
    # Define abilities for the passed in mailbox here.
    
    mailbox ||= Mailbox.new # Not logged in
    
    if mailbox.admin?
      can :manage, :all
    elsif mailbox.id
      # Domain
      can :read, Domain do |subject|
        subject.permission? :editor, mailbox
      end
      can [:edit, :update], Domain do |subject|
        subject.permission? :editor, mailbox
      end
      can [:destroy, :permissions], Domain do |subject|
        subject.permission? :owner, mailbox
      end

      # Mailbox and Alias
      [Alias, Mailbox].each do |model|
        can :index, model
        can [:create, :edit, :update], model do |subject|
          subject.domain.permission? :editor, mailbox #unless subject.domain.nil?
        end
        can [:destroy, :permissions], model do |subject|
          subject.domain.permission? :owner, mailbox
        end
      end
    end
  end
end
