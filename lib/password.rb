# Password generation module.
module Password
  # Dovecot compatible sha512-crypt hashes.
  module Sha512Crypt
    # Character set, a salt is generated from. Alphanumerics (case-sensitive)
    # plus slash and dot.
    SEEDS = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a + ['/', '.']

    # Generate 16 characters long alphanumeric salt.
    def self.generate_salt
      salt = ''

      16.times do
        salt << SEEDS[SecureRandom.random_number(SEEDS.size)].to_s
      end

      salt
    end
  end

  # Random string, n characters long. By default alphanumeric plus special
  # characters if az is set to true, only use downcase letters.
  def self.random(n = 12, az = false)
    a = az ? ('a'..'z').to_a : ('0'..'z').to_a
    a.shuffle.first(n).join
  end
end
