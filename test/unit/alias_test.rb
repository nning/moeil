require 'test_helper'

# Tests for app/models/alias.rb
class AliasTest < ActiveSupport::TestCase
  should belong_to :domain

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
    should_not allow_value(nil).for(:goto)
  end

  context 'Instance' do
    setup do
      @alias = FactoryGirl.create :alias
    end

    should 'return E-Mail address' do
      assert_equal @alias.email, [@alias.username, @alias.domain.name].join('@')
    end
  end
end
