require 'test_helper'
require 'functional/admin/test_helper.rb'

# Tests for app/controllers/admin/mailboxes_controller.rb
class Admin::MailboxesControllerTest < ActionController::TestCase
  context 'As admin' do
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
          @mailbox = FactoryGirl.build :mailbox, domain_id: @domain_id
          post :create,
            domain_id: @domain_id,
            mailbox: {
              username: @mailbox.username,
              domain_id: @domain_id,
              password: @mailbox.password,
              name: @mailbox.name
            }
        end

        context 'record' do
          setup do
            @new_record = Mailbox.where(username: @mailbox.username, domain_id: @domain_id).first
          end

          should 'be created' do
            assert @new_record
          end

          should 'have a sha512-crypt password' do
            assert @new_record.encrypted_password.starts_with? '$6$'
          end

          context 'hash' do
            setup do
              @method = ->(*args) do
                Devise::Encryptable::Encryptors::Sha512Dovecot.send(:digest, *args)
              end
              @params = [@mailbox.password, nil, @new_record.password_salt, nil]
            end

            should 'be correctly set' do
              assert_equal @new_record.encrypted_password, @method.call(*@params)
            end
          end
        end

        should respond_with(:redirect)
        should set_the_flash.to(/created/i)
      end

      context 'to update' do
        setup do
          @mailbox = FactoryGirl.create :mailbox
          @domain_id = @mailbox.domain_id

          post :update,
            id: @mailbox.id,
            domain_id: @domain_id,
            mailbox: {
              username: 'new-username'
            }
        end

        should 'change the record' do
          assert Mailbox.where(username: 'new-username', domain_id: @domain_id).first
          assert !Mailbox.where(username: @mailbox.username, domain_id: @domain_id).first
        end

        should respond_with(:redirect)
        should set_the_flash.to(/successfully updated/i)
      end
    end

    context 'on DELETE to destroy' do
      setup do
        @mailbox = FactoryGirl.create :mailbox
        delete :destroy, id: @mailbox.id, domain_id: @mailbox.domain_id
      end

      should 'delete the record' do
        assert !Mailbox.where(username: @mailbox.username, domain_id: @mailbox.domain_id).first
      end

      should respond_with(:redirect)
      should set_the_flash.to(/successfully destroyed/i)
    end
  end

  context 'With role' do
    setup do
      @mailbox = FactoryGirl.create :mailbox
      @domain_id = @mailbox.domain_id
    end

    context 'owner' do
      setup do
        @mailbox.domain.permissions.create! \
          subject: @mailbox,
          role: 'owner'
        sign_in @mailbox
      end

      should 'have owner permission' do
        assert @mailbox.domain.permission? :owner, @mailbox
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
            @new_mailbox = FactoryGirl.build :mailbox, domain_id: @domain_id
            post :create,
              domain_id: @domain_id,
              mailbox: {
                username: @new_mailbox.username,
                domain_id: @domain_id,
                password: @new_mailbox.password,
                name: @new_mailbox.name
              }
          end

          should 'create a record' do
            assert Mailbox.where(username: @new_mailbox.username, domain_id: @domain_id).first
          end

          should respond_with(:redirect)
          should set_the_flash.to(/created/i)
        end

        context 'to update' do
          setup do
            @new_mailbox = FactoryGirl.create :mailbox, domain_id: @domain_id
            post :update,
              id: @new_mailbox.id,
              domain_id: @domain_id,
              mailbox: {
                username: 'new-username'
              }
          end

          should 'change the record' do
            assert Mailbox.where(username: 'new-username', domain_id: @domain_id).first
            assert !Mailbox.where(username: @new_mailbox.username, domain_id: @domain_id).first
          end

          should respond_with(:redirect)
          should set_the_flash.to(/successfully updated/i)
        end
      end

      context 'on DELETE to destroy' do
        setup do
          @new_mailbox = FactoryGirl.create :mailbox, domain_id: @domain_id
          delete :destroy, id: @new_mailbox.id, domain_id: @domain_id
        end

        should 'delete the record' do
          assert !Mailbox.where(username: @new_mailbox.username, domain_id: @domain_id).first
        end

        should respond_with(:redirect)
        should set_the_flash.to(/successfully destroyed/i)
      end
    end

    context 'editor' do
      setup do
        @mailbox.domain.permissions.create! \
          subject: @mailbox,
          role: 'editor'
        sign_in @mailbox
      end

      should 'have owner permission' do
        assert @mailbox.domain.permission? :editor, @mailbox
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
            @new_mailbox = FactoryGirl.build :mailbox, domain_id: @domain_id
            post :create,
              domain_id: @domain_id,
              mailbox: {
                username: @new_mailbox.username,
                domain_id: @domain_id,
                password: @new_mailbox.password,
                name: @new_mailbox.name
              }
          end

          should 'create a record' do
            assert Mailbox.where(username: @new_mailbox.username, domain_id: @domain_id).first
          end

          should respond_with(:redirect)
          should set_the_flash.to(/created/i)
        end

        context 'to update' do
          setup do
            @new_mailbox = FactoryGirl.create :mailbox, domain_id: @domain_id
            post :update,
              id: @new_mailbox.id,
              domain_id: @domain_id,
              mailbox: {
                username: 'new-username'
              }
          end

          should 'change the record' do
            assert Mailbox.where(username: 'new-username', domain_id: @domain_id).first
            assert !Mailbox.where(username: @new_mailbox.username, domain_id: @domain_id).first
          end

          should respond_with(:redirect)
          should set_the_flash.to(/successfully updated/i)
        end
      end

      context 'on DELETE to destroy' do
        setup do
          @new_mailbox = FactoryGirl.create :mailbox, domain_id: @domain_id
          delete :destroy, id: @new_mailbox.id, domain_id: @domain_id
        end

        should 'delete the record' do
          assert !Mailbox.where(username: @new_mailbox.username, domain_id: @domain_id).first
        end

        should respond_with(:redirect)
        should set_the_flash.to(/successfully destroyed/i)
      end
    end
  end
end
