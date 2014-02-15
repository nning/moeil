# Domain model.
class Domain < ActiveRecord::Base
  include Permissionable

  has_many :aliases, dependent: :destroy
  has_many :mailboxes, dependent: :destroy

  attr_accessible :active, :backupmx, :catch_all_address, :description, :name,
    :quick_access

  default_scope order('name asc')

  scope :quick_access, where(quick_access: true)

  validates :name,
    format: { with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix },
    presence: true

  has_paper_trail

  before_save -> { name.downcase! }

  # Aliases count for simple_form.
  def aliases_count
    aliases.count
  end

  # Forwarding of all mails to non-existing addresses.
  def catch_all_alias
    aliases.where(username: nil).first
  end

  # Target(s) of catch all Alias.
  def catch_all_address
    catch_all_alias.try :goto
  end

  # Setter for target(s) of catch all Alias.
  def catch_all_address=(goto)
    return catch_all_alias.try(:destroy) if goto.blank?

    a = catch_all_alias || aliases.build
    a.goto = goto
    a.save! validate: false
  end

  # Returns URL array for editing a model instance.
  def edit_url_array
    [:edit, :admin, self]
  end

  # Mailboxes count for simple_form.
  def mailboxes_count
    mailboxes.count
  end

  # Mailboxes for select input.
  def mailboxes_for_select
    mailboxes.map { |m| [m.email, m.id] }
  end

  # String representation.
  def to_s
    name
  end

  # Default Domain. (First one, if not configured in config/settings.yml).
  def self.default
    domain = where(name: Settings.default_domain).limit(1).first
    domain = Domain.first if domain.nil?

    domain
  end

  # Managable Domains for given mailbox.
  def self.managable(mailbox)
    if mailbox.admin?
      Domain
    else
      Domain.includes(:permissions).where('
        (permissions.role = "editor" or permissions.role = "owner")
        and subject_id = ?',
        mailbox.id
      )
    end
  end
end
