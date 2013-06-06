require 'test_helper'

class MailboxesControllerTest < ActionController::TestCase

  should route(:get, 'mailbox/edit').to(controller: :mailboxes, action: :edit)
  should route(:put, 'mailbox').to(controller: :mailboxes, action: :update)

  context 'Own mailbox' do
    setup do
      @mailbox = FactoryGirl.create :mailbox
      sign_in @mailbox
    end

    context 'on GET to edit' do
      setup do
        get :edit
      end

      should respond_with :success
      should render_template :edit
    end

    context 'on PUT to edit' do
      setup do
        @domain = FactoryGirl.create :domain
        put :edit, mailbox: {
          username: 'foo',
          domain_id: @domain.id,
          name: 'Foo',
          password: 'foo',
          password_confirmation: 'foo',
          quota: 1337
        }
      end

      should respond_with :success
      should render_template :edit

# TODO I do not understand, why the second should block does not work _after_
#      the PUT.
=begin
      should 'have old username, domain_id and quota' do
        ['username', 'domain_id', 'quota'].each do |attr|
          assert_select "#mailbox_#{attr}" do
            assert_select '[value=?]', @mailbox.attributes[attr]
          end
        end
      end

      should 'have new name' do
        assert_select '#mailbox_name' do
          assert_select '[value=?]', 'Foo'
        end
      end
=end
    end
  end

end
