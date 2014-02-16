require 'test_helper'

# Tests for app/controllers/admin/searches_controller.rb
class Admin::SearchesControllerTest < ActionController::TestCase
  should route(:post, 'admin/search').to('admin/searches#search')

  context 'Admin namespace' do
    setup do
      @mailbox = FactoryGirl.create :mailbox, admin: true
      @domain = @mailbox.domain
      sign_in @mailbox
    end

    context 'search' do
      setup do
        @alias = FactoryGirl.create :alias, domain: @domain
      end

      context 'on POST to search (for Domain)' do
        setup do
          post :search, q: @domain.name.random_substring
        end

        should respond_with :success
        should render_template 'admin/searches/search'
      end
    end
  end
end
