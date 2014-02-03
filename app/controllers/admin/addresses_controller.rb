class Admin::AddressesController < AdminController

  inherit_resources

  load_and_authorize_resource :domain

  actions :all, except: :show

  belongs_to :domain


  def create
    create! do |success, error|
      success.html { redirect_to collection_url }
    end
  end

  def destroy
    destroy! do |success, error|
      success.html { redirect_to collection_url }
    end
  end

  def update
    update! do |success, error|
      success.html { redirect_to collection_url }
    end
  end

end
