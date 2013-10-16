require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  
  should belong_to :creator
  should belong_to :item
  should belong_to :subject
  
  ['owner', 'editor'].each do |val|
    should allow_value(val).for :role
  end

  [nil, '', 'foo'].each do |val|
    should_not allow_value(val).for :role
  end
  
  context 'Domain' do
    setup do
      @domain = FactoryGirl.create :domain
    end

    context 'admin user' do
      setup do
        @mailbox = FactoryGirl.create :mailbox, admin: true
      end

      should 'have owner and editor permissions' do
        assert @domain.permission?(:owner,  @mailbox)
        assert @domain.permission?(:editor, @mailbox)
      end
    end

    context 'owner user' do
      setup do
        @permission = FactoryGirl.create :permission, item: @domain
      end

      should 'have owner and editor permissions' do
        assert @domain.permission?(:owner,  @permission.subject)
        assert @domain.permission?(:editor, @permission.subject)
      end
    end

    context 'editor user' do
      setup do
        @permission = FactoryGirl.create :permission, item: @domain, role: 'editor'
      end

      should 'have editor permission' do
        assert @domain.permission?(:editor, @permission.subject)
      end
    end

    context 'bernd' do
      should 'not have any permissions' do
        assert !@domain.permission?(:owner,  nil)
        assert !@domain.permission?(:editor, nil)
      end
    end

    context 'editor' do
      setup do
        @permission = FactoryGirl.create :permission, item: @domain, role: 'editor'
      end

      should 'not have owner permission' do
        assert !@domain.permission?(:owner, @permission.subject)
      end
    end

    context 'some user' do
      setup do
        @mailbox = FactoryGirl.create :mailbox
      end

      should 'not have permissions without mailbox having permissions' do
        assert !@domain.permission?(:owner,  @mailbox)
        assert !@domain.permission?(:editor, @mailbox)
      end
    end
  end
end
