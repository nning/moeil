require 'test_helper'

class Admin::MailboxesControllerTest < ActionController::TestCase

  context 'Admin namespace' do
    context 'as admin' do
      setup do
        @mailbox = FactoryGirl.create :mailbox, admin: true
        sign_in @mailbox
      end

      context 'on GET to index' do
        setup do
          get :index
        end

        should respond_with :success
        should render_template 'admin/mailboxes/index'
        should render_template 'admin/mailboxes/_mailbox'
      end

      # TODO Write more tests.
    end
  end

end
