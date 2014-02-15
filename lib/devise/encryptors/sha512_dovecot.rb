# Devise encryptor for dovecot compatible SHA512 hash.
module Devise
  # Namespace for devise-encryptable gem.
  module Encryptable
    # Namespace for custom devise encryptors.
    module Encryptors
      # Devise encryptor for dovecot compatible SHA512 hash.
      class Sha512Dovecot < Base
        def self.digest(password, stretches, salt, pepper)
          password.crypt('$6$' + salt)
        end
      end
    end
  end
end
