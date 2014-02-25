require 'test_helper'

# Tests for app/controllers/admin/searches_controller.rb
class Admin::SearchesControllerTest < ActionController::TestCase
  should route(:post, 'admin/search').to(controller: 'admin/searches', action: :search)

  context 'Admin namespace' do
    setup do
      @mailbox = FactoryGirl.create :mailbox, admin: true
      @domain = @mailbox.domain
      @alias = FactoryGirl.create :alias, domain: @domain
      [Alias, Domain, Mailbox].map(&:reindex)
      sign_in @mailbox
    end

    context 'search' do
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
