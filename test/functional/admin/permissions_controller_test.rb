require 'test_helper'

class Admin::PermissionsControllerTest < ActionController::TestCase

  context 'As admin' do
    setup do
      @mailbox = FactoryGirl.create :mailbox, admin: true
      @domain_id = @mailbox.domain_id
      sign_in @mailbox
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

        should 'create a record' do
          assert Permission
            .role(@permission.role)
            .subject(@permission.subject)
            .item(@permission.item)
            .first
        end

        should respond_with :redirect
        should set_the_flash.to /created/i
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

        should respond_with :redirect
        should set_the_flash.to /successfully updated/i
      end
    end

    context 'on DELETE to destroy' do
      setup do
        @permission = FactoryGirl.create :permission, item: @mailbox.domain
        delete :destroy, id: @permission.id, domain_id: @mailbox.domain_id
      end

      should 'delete the record' do
        assert !Permission
          .role(@permission.role)
          .subject(@permission.subject)
          .item(@permission.item)
          .first
      end

      should respond_with :redirect
      should set_the_flash.to /successfully destroyed/i
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
            @permission = FactoryGirl.build :permission, item: @mailbox.domain
            post :create,
              domain_id: @domain_id,
              permission: {
                subject_id:   @permission.subject.id,
                subject_type: @permission.subject.class,
                role:         @permission.role
              }
          end

          should 'create a record' do
            assert Permission
              .role(@permission.role)
              .subject(@permission.subject)
              .item(@permission.item)
              .first
          end

          should respond_with :redirect
          should set_the_flash.to /created/i
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

          should respond_with :redirect
          should set_the_flash.to /successfully updated/i
        end
      end

      context 'on DELETE to destroy' do
        setup do
          @permission = FactoryGirl.create :permission, item: @mailbox.domain
          delete :destroy, id: @permission.id, domain_id: @mailbox.domain_id
        end

        should 'delete the record' do
          assert !Permission
            .role(@permission.role)
            .subject(@permission.subject)
            .item(@permission.item)
            .first
        end

        should respond_with :redirect
        should set_the_flash.to /successfully destroyed/i
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
