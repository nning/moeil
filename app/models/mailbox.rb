class Mailbox < ActiveRecord::Base

  belongs_to :domain
  attr_accessible :active, :mail_location, :name, :password, :quota, :username

  def sha512_crypt_password=(password)
    self.password = Password::Crypt::SHA512.new(password).to_s
    save!
  end

  def md5_crypt_password=(password)
    self.password = Password::Crypt::MD5.new(password).to_s
    save!
  end

end
