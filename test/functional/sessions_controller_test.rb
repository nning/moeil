require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  should route(:get, 'login').to(controller: :sessions, action: :new)
  should route(:post, 'login').to(controller: :sessions, action: :create)
  should route(:delete, 'logout').to(controller: :sessions, action: :destroy)

  context 'Login' do
    setup do
      request.env['devise.mapping'] = Devise.mappings[:mailbox]
      @mailbox = FactoryGirl.create :mailbox, password: 'whatever'
    end

    context 'on GET to new' do
      setup do
        get :new
      end

      should respond_with :success
      should render_template :new
    end

    context 'on POST to create' do
      context 'with correct password' do
        setup do
          post :create, mailbox: { email: @mailbox.email, password: 'whatever' }
        end

        should respond_with :redirect
        should redirect_to '/mailbox/edit'
      end

      context 'with wrong password' do
        setup do
          post :create, mailbox: { email: @mailbox.email, password: 'everwhat' }
        end

        should respond_with :success
        should render_template :new
      end
    end
  end

end
