class Mailbox < ActiveRecord::Base

  belongs_to :domain
  has_one :relocation, dependent: :destroy

  devise :database_authenticatable, :encryptable

  attr_accessible :active, :admin, :current_password, :domain_id,
    :mail_location, :name, :password, :password_confirmation, :quota, :username

  before_save :create_relocation

  default_scope order('username asc')


  validates :username,
    presence: true,
    uniqueness: {
      scope: :domain_id,
      message: 'Combination of username and domain is not unique.'
    },
    format: {
      with: /\A[a-zA-Z0-9.\-_]+\z/,
      message: 'Username contains invalid characters.'
    },
    exclusion: {
      in: Settings.blocked_usernames,
      message: 'Username is blocked.'
    }

  validates :domain_id, presence: true
  validates :encrypted_password, presence: true


  def aliases
    Alias.where('goto like ?', email)
  end

  def email
    [self.username, self.domain.name].join '@' rescue nil
  end

  def password_salt
    salt = self.encrypted_password.split('$')[2] rescue nil
    return Password::Sha512Crypt.generate_salt if salt.blank?
    salt
  end

  def password_salt=(value)
  end

  def password_scheme
    { 1 => :md5_crypt, 6 => :sha512_crypt }[encrypted_password.split('$')[1].to_i]
  end

private

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

end
