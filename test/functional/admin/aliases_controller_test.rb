require 'test_helper'

class Admin::AliasesControllerTest < ActionController::TestCase

  context 'Admin namespace' do
    context 'as admin' do
      setup do
        @mailbox = FactoryGirl.create :mailbox, admin: true
        sign_in @mailbox
      end

      context 'on GET to index' do
        setup do
          get :index, domain_id: @mailbox.domain.id
        end

        should respond_with :success
        should render_template 'admin/aliases/index'
      end

      # TODO Write more tests.
    end
  end

end
