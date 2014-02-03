if RUBY_PLATFORM == 'java'
  require File.join(Rails.root, 'lib', 'java', 'commons-codec-1.8.jar')

  class String
    def crypt(salt)
      org.apache.commons.codec.digest.Crypt.crypt(self.to_java_bytes, salt)
    end
  end
end
