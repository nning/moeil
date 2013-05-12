class Mailbox < ActiveRecord::Base

  belongs_to :domain
  attr_accessible :active, :created_at, :mail_location, :name, :password, :quota, :updated_at, :username

  def crypt_password(password, hash)
    self.password = password.crypt(generate_salt(hash))
    save!
  end

  def sha512_crypt_password=(password)
    crypt_password password, :sha512
  end

  def md5_crypt_password=(password)
    crypt_password password, :md5
  end

private

  def generate_salt(hash)
    seeds = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a + ['/', '.']
    config = {sha512: ['$6$', 16], md5: ['$1$', 8]}
    salt_string = config[hash].first

    config[hash].last.times do
      salt_string << seeds[rand(seeds.size)].to_s
    end

    salt_string
  end

end
