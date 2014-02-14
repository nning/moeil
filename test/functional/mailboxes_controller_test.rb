require 'test_helper'

# Tests for app/controllers/mailboxes_controller.rb
class MailboxesControllerTest < ActionController::TestCase

  should route(:get, 'mailbox/edit').to(controller: :mailboxes, action: :edit)
  should route(:put, 'mailbox').to(controller: :mailboxes, action: :update)

  context 'Own mailbox' do
    setup do
      @mailbox = FactoryGirl.create :mailbox, password: 'whatever'
      sign_in @mailbox
    end

    context 'on GET to edit' do
      setup do
        get :edit
      end

      should respond_with :success
      should render_template :edit
    end

    context 'on POST to update' do
      setup do
        @new_domain = FactoryGirl.create :domain

        put :update,
          mailbox: {
            username: 'foo',
            domain_id: @new_domain.id,
            name: 'Foo',
            password: 'everwhat',
            password_confirmation: 'everwhat',
            quota: 1337,
            mail_location: '/',
            active: false,
            admin: true
          }

        @mailbox.reload
      end

      should respond_with :redirect
      should set_the_flash.to /successfully updated/i

      should 'have new name' do
        assert_equal 'Foo', @mailbox.name
      end

      should 'have old username' do
        assert @mailbox.username != 'foo'
      end

      should 'have old domain_id' do
        assert @mailbox.domain_id != @new_domain.id
      end

      should 'have old quota' do
        assert @mailbox.quota != 1337
      end

      should 'have old mail_location' do
        assert @mailbox.quota != '/'
      end

      should 'have old active' do
        assert @mailbox.active
      end

      should 'have old admin' do
        assert !@mailbox.admin
      end
    end
  end

end
