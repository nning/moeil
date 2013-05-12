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
        @password = password.crypt(Crypt.generate_salt(:sha512))
      end
    end

    class MD5 < HashedPassword
      def initialize(password)
        @password = password.crypt(Crypt.generate_salt(:md5))
      end
    end

  private

    def self.generate_salt(hash)
      salt = CONFIG[hash].first

      CONFIG[hash].last.times do
        salt << SEEDS[rand(SEEDS.size)].to_s
      end

      salt
    end

  end

end
