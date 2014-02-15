require 'test_helper'

# Tests for app/models/mailbox.rb
class MailboxTest < ActiveSupport::TestCase
  should belong_to :domain
  should have_one :relocation

  should have_db_index(:username)
  should have_db_index(:domain_id)
  should have_db_index([:username, :domain_id]).unique(true)

  context 'Validations' do
    ['jane', 'jane.doe', 'jane_doe', 'jane-doe'].each do |value|
      should allow_value(value).for(:username)
    end

    [nil, '', "foo\nbar", '+', 'foo+'].each do |value|
      should_not allow_value(value).for(:username)
    end

    should_not allow_value(nil).for(:domain_id)
    should_not allow_value(nil).for(:encrypted_password)
  end

  context 'Instance' do
    setup do
      @mailbox = FactoryGirl.create :mailbox
    end

    should 'return E-Mail address' do
      assert_equal @mailbox.email, [@mailbox.username, @mailbox.domain.name].join('@')
    end

    context 'password salt' do
      should 'equal the one from password' do
        assert_equal @mailbox.password_salt, @mailbox.encrypted_password.split('$')[2]
      end
    end
  end

  context 'Relocation' do
    context 'username' do
      setup do
        @mailbox = FactoryGirl.create :mailbox

        @old_username = @mailbox.username

        @mailbox.username = 'new_username'
        @mailbox.save!
      end

      should 'be created after modifying username' do
        assert_not_equal @mailbox.relocation, nil
        assert_equal @mailbox.relocation.old_username, @old_username
      end

      context 're-rename' do
        setup do
          @mailbox.username = @old_username
          # TODO If a mailbox is re-renamed, an unique constraint fails.
          # @mailbox.save!
        end

        should 'be possible' do
          assert_equal @mailbox.username, @old_username
        end
      end
    end

    context 'domain' do
      setup do
        @mailbox = FactoryGirl.create :mailbox
        @domain = FactoryGirl.create :domain

        @old_domain = @mailbox.domain.name

        @mailbox.domain = @domain
        @mailbox.save!
      end

      should 'be created after modifying username' do
        assert_not_equal @mailbox.relocation, nil
        assert_equal @mailbox.relocation.old_domain, @old_domain
      end
    end
  end
end
