require 'test_helper'

# Tests for lib/password.rb
class PasswordTest < ActiveSupport::TestCase

  context 'sha512_crypt' do
    context 'salt' do
      setup do
        @method = ->() { Password::Sha512Crypt.generate_salt }
      end

      should 'not be blank' do
        [nil, ''].map { |x| assert_not_equal x, @method.call }
      end

      should 'vary' do
        assert_not_equal @method.call, @method.call
      end
    end

    context 'devise encryptor' do
      setup do
        @method = ->(*args) do
          Devise::Encryptable::Encryptors::Sha512Dovecot.send(:digest, *args)
        end

        @password = Password.random
        @salt = Password::Sha512Crypt.generate_salt

        @params = [@password, nil, @salt, nil]
      end

      should 'return nothing blank' do
        [nil, ''].map { |x| assert_not_equal x, @method.call(*@params) }
      end

      should 'return sha512' do
        assert @method.call(*@params).start_with? '$6$'
      end

      should 'return same hashes with same password and salt' do
        assert_equal @method.call(*@params), @method.call(*@params)
      end
    end
  end

  context 'random password' do
    setup do
      @method = ->(n = 12) { Password.random(n) }
    end

    should 'not be blank' do
      [nil, ''].map { |x| assert_not_equal x, @method.call }
    end

    should 'have correct size' do
      n = rand(50)
      assert_equal n, @method.call(n).size
    end

    should 'vary' do
      assert_not_equal @method.call, @method.call
    end
  end

end
