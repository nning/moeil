require 'test_helper'

# Tests for app/controllers/admin/versions_controller.rb
class Admin::VersionsControllerTest < ActionController::TestCase
  context 'Admin namespace' do
    context 'as admin' do
      setup do
        @mailbox = FactoryGirl.create :mailbox, admin: true
        sign_in @mailbox

        m = FactoryGirl.create :mailbox
        m.domain.destroy
      end

      context 'on GET to index' do
        setup do
          get :index
        end

        should respond_with :success
        should render_template 'admin/versions/index'
        should render_template 'admin/versions/_version'
      end

      # TODO Write more tests.
#     context 'on POST to revert' do
#     end
    end
  end
end
