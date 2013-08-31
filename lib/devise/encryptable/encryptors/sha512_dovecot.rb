module Devise
  module Encryptable
    module Encryptors
      class Sha512Dovecot < Base
        def self.digest(password, stretches, salt, pepper)
          password.crypt('$6$' + salt)
        end
      end
    end
  end
end
