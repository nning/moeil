require 'test_helper'

# Tests for app/models/domain.rb
class DomainTest < ActiveSupport::TestCase
  should have_many :aliases
  should have_many :mailboxes

  should have_db_index(:name).unique(true)

  context 'Validations' do
    ['example.com', 'example.org', 'a.de'].each do |value|
      should allow_value(value).for(:name)
    end

    [nil, '', 'a.b', '.org', "foo.com\nbar.org", '+.com', 'foo+.com'].each do |value|
      should_not allow_value(value).for(:name)
    end
  end

  context 'Instance' do
    setup do
      @domain = FactoryGirl.create :domain
    end

    context 'catch-all alias' do
      setup do
        @domain.catch_all_address = 'alice@example.org'
      end

      should 'be created if not existing' do
        assert_equal 1, @domain.aliases.count
        assert_equal 'alice@example.org', @domain.aliases.first.goto
      end

      should 'be deleted if blanked' do
        @domain.catch_all_address = nil
        assert_equal 0, @domain.aliases.count
      end

      should 'be overwritten if existing' do
        @domain.catch_all_address = 'bob@example.org'
        assert_equal 1, @domain.aliases.count
        assert_equal 'bob@example.org', @domain.aliases.first.goto
      end
    end

    context 'name' do
      setup do
        @domain.name = 'FOO.com'
        @domain.save!
      end

      should 'be downcased on save' do
        assert_equal 'foo.com', @domain.name
      end
    end

    context 'managable' do
      setup do
        @another_domain = FactoryGirl.create :domain
      end

      context 'admin' do
        setup do
          @mailbox = FactoryGirl.create :mailbox, domain: @domain, admin: true
        end

        should 'return everything' do
          assert_equal Domain.managable(@mailbox).all, Domain.all
        end
      end

      %w[owner editor].each do |role|
        context role do
          setup do
            @mailbox = FactoryGirl.create :mailbox, domain: @domain
            @domain.permissions.create!(subject: @mailbox, role: role)
            @managable = Domain.managable(@mailbox)
          end

          should 'return correct domain' do
            assert_equal @managable.all.size, 1
            assert_equal @managable.first, @domain
          end
        end
      end
    end
  end
end
