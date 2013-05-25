class Mailbox < ActiveRecord::Base
  belongs_to :domain

  devise :database_authenticatable, :encryptable

  attr_accessible :admin, :domain_id, :mail_location, :name, :password,
    :password_confirmation, :quota, :username


  validates :username,
    presence: true,
    uniqueness: {
      scope: :domain_id,
      message: 'Combination of username and domain is not unique.'
    },
    format: {
      with: /^[a-zA-Z0-9.\-_]+$/,
      message: 'Username contains invalid characters.'
    },
    exclusion: {
      in: Settings.blocked_usernames,
      message: 'Username is blocked.'
    }
  validates :domain_id, presence: true
  validates :encrypted_password, presence: true


  def email
    [self.username, self.domain.name].join('@') rescue nil
  end

  def password_salt
    salt = self.encrypted_password.split('$')[2] rescue nil
    return Password::Sha512Crypt.generate_salt if salt.blank?
    salt
  end

  def password_salt=(value)
  end

  def password_scheme
    { 1 => :md5_crypt, 6 => :sha512_crypt }[encrypted_password.split('$')[1]]
  end

end
