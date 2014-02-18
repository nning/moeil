# Mailbox model (also used for login to Møil).
class Mailbox < ActiveRecord::Base
  include Address

  belongs_to :domain
  has_many   :permissions, dependent: :destroy, as: :subject
  has_one    :relocation,  dependent: :destroy

  attr_accessible :active, :admin, :domain_id, :mail_location, :name, :password,
    :password_confirmation, :quota, :username

  default_scope order('username asc')

  validates :password,
    presence: {
      if: :password_required?
    },
    confirmation: {
      if: :password
    },
    length: {
      in: Settings.minimal_password_length.to_i..128,
      allow_blank: true
    }

  validates :encrypted_password, presence: true

  before_save :create_relocation

  devise :database_authenticatable, :encryptable

  has_paper_trail

  default_value_for :quota, Settings.default_quota

  searchkick word_middle: [:name, :username]
  # Search fields options includable in search on model.
  SEARCH_FIELDS = [
    { name: :word_middle },
    { username: :word_middle }
  ]

  # Aliases pointing to Mailbox.
  def aliases
    Alias.where('goto like ?', email)
  end

  # E-Mail address.
  def email
    [self.username, self.domain.name].join '@' rescue nil
  end

  # Mailboxes this mailbox has access to for select input.
  def mailboxes_for_select
    domains = admin? ? Domain.all : permissions.map(&:item)
    domains.map(&:mailboxes_for_select).flatten(1)
  end

  # Does this Mailbox have permission to change Domains?
  def manager?
    permissions.any? || admin?
  end

  # Salt of the password hash.
  def password_salt
    salt = self.encrypted_password.split('$')[2] rescue nil
    return Password::Sha512Crypt.generate_salt if salt.blank?
    salt
  end

  # Dummy setter for password hash salt.
  def password_salt=(value)
  end

  # Permissions of this Mailbox.
  def permissions
    Permission.subject self
  end

  # String representation.
  def to_s
    domain ? email : "#{username}@#{domain_id}"
  end

  private

  # Create Relocation if username or Domain changed.
  def create_relocation
    if persisted? and (username_changed? or domain_id_changed?)
      old_username = if username_changed?
        changes[:username].first
      else
        username
      end

      old_domain = if domain_id_changed?
        Domain.find_by_id(changes[:domain_id].first).name
      else
        domain.name
      end

      create_relocation! old_username: old_username, old_domain: old_domain
    end
  end

  # Is current password required? (For validations.)
  def password_required?
    !(persisted? || password.nil? || password_confirmation.nil?)
  end
end
