require 'test_helper'
require 'functional/admin/test_helper.rb'

# Tests for app/controllers/admin/permissions_controller.rb
class Admin::PermissionsControllerTest < ActionController::TestCase
  # Build dummy permission and POST to permissions#create.
  def post_to_create
    @permission = FactoryGirl.build :permission, item: @mailbox.domain
    post :create,
      domain_id: @domain_id,
      permission: {
        subject_id:   @permission.subject.id,
        subject_type: @permission.subject.class,
        role:         @permission.role
      }
  end

  # Create dummy permission and DELETE to permissions#destroy.
  def delete_to_destroy
    @permission = FactoryGirl.create :permission, item: @mailbox.domain
    delete :destroy, id: @permission.id, domain_id: @mailbox.domain_id
  end

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

    context 'on POST to' do
      context 'create' do
        setup do
          post_to_create
        end

        should 'create a record' do
          assert Permission
            .role(@permission.role)
            .subject(@permission.subject)
            .item(@permission.item)
            .first
        end

        should respond_with(:redirect)
        should set_the_flash.to(/created/i)
      end

      context 'update' do
        setup do
          @permission = FactoryGirl.create :permission, item: @mailbox.domain
          post :update,
            id: @permission.id,
            domain_id: @domain_id,
            permission: {
              role: 'editor'
            }
        end

        should 'change the record' do
          assert Permission
            .role('editor')
            .subject(@permission.subject)
            .item(@permission.item)
            .first
          assert !Permission
            .role(@permission.role)
            .subject(@permission.subject)
            .item(@permission.item)
            .first
        end

        should respond_with(:redirect)
        should set_the_flash.to(/successfully updated/i)
      end
    end

    context 'on DELETE to destroy' do
      setup do
        delete_to_destroy
      end

      should 'delete the record' do
        assert !Permission
          .role(@permission.role)
          .subject(@permission.subject)
          .item(@permission.item)
          .first
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

      context 'on POST to' do
        context 'create' do
          setup do
            post_to_create
          end

          should 'create a record' do
            assert Permission
              .role(@permission.role)
              .subject(@permission.subject)
              .item(@permission.item)
              .first
          end

          should respond_with(:redirect)
          should set_the_flash.to(/created/i)
        end

        context 'update' do
          setup do
            @permission = FactoryGirl.create :permission, item: @mailbox.domain
            post :update,
              id: @permission.id,
              domain_id: @domain_id,
              permission: {
                role: 'editor'
              }
          end

          should 'change the record' do
            assert Permission
              .role('editor')
              .subject(@permission.subject)
              .item(@permission.item)
              .first
            assert !Permission
              .role(@permission.role)
              .subject(@permission.subject)
              .item(@permission.item)
              .first
          end

          should respond_with(:redirect)
          should set_the_flash.to(/successfully updated/i)
        end
      end

      context 'on DELETE to destroy' do
        setup do
          delete_to_destroy
        end

        should 'delete the record' do
          assert !Permission
            .role(@permission.role)
            .subject(@permission.subject)
            .item(@permission.item)
            .first
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

      should 'have editor permission' do
        assert  @mailbox.domain.permission?(:editor, @mailbox)
        assert !@mailbox.domain.permission?(:owner,  @mailbox)
      end

      context 'on GET to index' do
        setup do
          get :index, domain_id: @domain_id
        end

        should respond_with :success
        should render_template :index
      end

      context 'on POST to' do
        context 'create' do
          setup do
            @permission = FactoryGirl.build :permission, item: @mailbox.domain
            post :create,
              domain_id: @domain_id,
              permission: {
                subject_id:   @permission.subject.id,
                subject_type: @permission.subject.class,
                role:         @permission.role
              }
          end

          should respond_with :not_found

          should 'not create a record' do
            assert !Permission
              .role(@permission.role)
              .subject(@permission.subject)
              .item(@permission.item)
              .first
          end
        end

        context 'update' do
          setup do
            @permission = FactoryGirl.create :permission, item: @mailbox.domain
            post :update,
              id: @permission.id,
              domain_id: @domain_id,
              permission: {
                role: 'editor'
              }
          end

          should respond_with :not_found

          should 'not change the record' do
            assert Permission
              .role(@permission.role)
              .subject(@permission.subject)
              .item(@permission.item)
              .first
            assert !Permission
              .role('editor')
              .subject(@permission.subject)
              .item(@permission.item)
              .first
          end
        end
      end

      context 'on DELETE to destroy' do
        setup do
          @permission = FactoryGirl.create :permission, item: @mailbox.domain
          delete :destroy, 
            domain_id: @mailbox.domain_id,
            id: @permission.id
        end

        should respond_with :not_found

        should 'not delete the record' do
          assert Permission
            .role(@permission.role)
            .subject(@permission.subject)
            .item(@permission.item)
            .first
        end
      end
    end
  end
end
