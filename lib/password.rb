module Password

  module Crypt

    CONFIG = {
      sha512: ['$6$', 16],
      md5:    ['$1$',  8]
    }

    SEEDS = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a + ['/', '.']

    class HashedPassword
      attr_reader :password

      def to_s
        @password
      end
    end

    class SHA512 < HashedPassword
      def initialize(password)
        @password = password.crypt(Crypt.generate_salt)
      end
    end

    class MD5 < HashedPassword
      def initialize(password)
        @password = password.crypt(Crypt.generate_salt(:md5))
      end
    end

    def self.generate_salt(hash = :sha512)
      begin
        salt = CONFIG[hash].first.dup
      rescue NoMethodError
        raise "No information on hashing algorithm '#{hash.to_s}'."
      end

      CONFIG[hash].last.times do
        salt << SEEDS[SecureRandom.random_number(SEEDS.size)].to_s
      end

      salt
    end

  end

  def self.check(password, hash)
    a = hash.split('$')
    a.delete_at(-1)
    password.crypt(a.join('$')) == hash
  end

  def self.random(n = 12)
    ('0'..'z').to_a.shuffle.first(n).join
  end

end
