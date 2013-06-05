require 'test_helper'

class MailboxTest < ActiveSupport::TestCase
  should belong_to :domain
  should have_one :relocation

  should have_db_index(:username)
  should have_db_index(:domain_id)
  should have_db_index([:username, :domain_id]).unique true

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
end
