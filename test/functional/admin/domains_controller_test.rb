require 'test_helper'

class Admin::DomainsControllerTest < ActionController::TestCase

  context 'Admin namespace' do
    context 'as admin' do
      setup do
        @mailbox = FactoryGirl.create :mailbox, admin: true
        sign_in @mailbox
      end

      context 'on GET to domain index' do
        setup do
          get :index
        end

        should respond_with :success
        should render_template 'admin/domains/index'
        should render_template 'admin/domains/_domain'
      end
    end

# TODO
=begin
    context 'not as admin' do
      setup do
        @mailbox = FactoryGirl.create :mailbox, admin: false
        sign_in @mailbox
      end

      context 'on GET to domain index' do
        setup do
          get :index
        end

        should raise_error ActiveRecord::RecordNotFound
      end
    end
=end
  end

end
