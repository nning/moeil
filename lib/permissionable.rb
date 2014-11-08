# Enables permission on models it is included into.
module Permissionable
  extend ActiveSupport::Concern

  included do
    has_many :permissions, as: :item, dependent: :destroy
  end

  # Dummy method for easier use in simple_form.
  def permissions_count
    permissions.count
  end
  
  # Does a Mailbox have at least role permission?
  def permission?(role, mailbox)
    # Deny if mailbox is nil.
    return false unless mailbox
    
    # Deny if mailbox is of wrong type.
    raise ArgumentError, 'No mailbox given.' unless mailbox.is_a? Mailbox
    
    # Allow any admin mailbox.
    return true if mailbox.admin?

    # Retrieve direct mailbox permissions.
    @perms = self.permissions.subject(mailbox).all

    # Deny if no permission is found.
    return false unless @perms

    # Allow if role matches any permission.
    @perms.flatten.each do |perm|
      return true if perm.role == role.to_s
      return true if perm.role == 'owner' and role == :editor
    end

    # Deny otherwise.
    false
  end
end
