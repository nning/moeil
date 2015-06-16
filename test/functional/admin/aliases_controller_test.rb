require 'test_helper'
require 'functional/admin/test_helper.rb'

# Tests for app/controllers/admin/aliases_controller.rb
class Admin::AliasesControllerTest < ActionController::TestCase
  context 'Admin namespace' do
    context 'as admin' do
      setup do
        create_and_sign_in_mailbox
      end

      context 'on GET to index' do
        setup do
          get :index, domain_id: @domain_id
        end

        should respond_with :success
        should render_template :index
      end

      context 'on POST' do
        context 'to create' do
          setup do
            @alias = FactoryGirl.build :alias, domain_id: @domain_id
            post :create,
              domain_id: @domain_id,
              alias: {
                username: @alias.username,
                domain_id: @domain_id,
                goto: @alias.goto
              }
          end

          should 'create a record' do
            assert Alias.where(username: @alias.username, domain_id: @domain_id).first
          end

          should respond_with :redirect
          should set_flash.to(/created/i)
        end

        context 'to update' do
          setup do
            @alias = FactoryGirl.create :alias
            @old_username = @alias.username
            @domain_id = @alias.domain_id

            post :update,
              id: @alias.id,
              domain_id: @domain_id,
              alias: {
                username: 'new-username'
              }
          end

          should 'change the record' do
            assert Alias.where(username: 'new-username', domain_id: @domain_id).first
            assert !Alias.where(username: @alias.username, domain_id: @domain_id).first
          end

          should respond_with :redirect
          should set_flash.to(/successfully updated/i)
        end
      end

      context 'on DELETE to destroy' do
        setup do
          @alias = FactoryGirl.create :alias
          delete :destroy, id: @alias.id, domain_id: @alias.domain_id
        end

        should 'delete the record' do
          assert !Alias.where(username: @alias.username, domain_id: @alias.domain_id).first
        end

        should respond_with :redirect
        should set_flash.to(/successfully destroyed/i)
      end
    end
  end
end
