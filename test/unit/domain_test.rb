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

end
