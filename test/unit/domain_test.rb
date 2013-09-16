require 'test_helper'

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
  end

end
