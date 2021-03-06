require 'test_helper'

# Tests for app/controllers/admin/domains_controller.rb
class Admin::DomainsControllerTest < ActionController::TestCase
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
        should render_template 'admin/domains/index'
        should render_template 'admin/domains/_domain'
      end

      context 'on GET to edit' do
        setup do
          get :edit, id: @mailbox.domain.id
        end

        should respond_with :success
        should render_template 'admin/domains/edit'
      end

# TODO This has to be solved.
=begin
      context 'on DESTROY to own domain' do
        setup do
          delete :destroy, id: @mailbox.domain.id
        end

        should respond_with :not_found
        should render_template nil
      end

      context 'on DESTROY to other domain' do
        setup do
          @domain = FactoryGirl.create :domain
          delete :destroy, id: @domain.id
        end

        should respond_with :redirect
        should render_template :index
      end
=end
    end
  end
end
