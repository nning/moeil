# Password generation module.
module Password
  module Sha512Crypt
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

  def self.random(n = 12)
    ('0'..'z').to_a.shuffle.first(n).join
  end
end
