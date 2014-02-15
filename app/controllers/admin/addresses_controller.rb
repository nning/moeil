# Shared code for Aliases and Mailboxes controller.
class Admin::AddressesController < AdminController
  inherit_resources

  load_and_authorize_resource :domain

  actions :all, except: :show

  belongs_to :domain

  # Redirect to collection URL after create, destroy and update actions.
  %w[create destroy update].each do |action|
    self.class.send(:define_method, action.to_sym) do
      super do |success, error|
        success.html { redirect_to collection_url }
      end
    end
  end
end
