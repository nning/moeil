class Admin::PermissionsController < AdminController

  inherit_resources
  actions :all, except: :show

  belongs_to :domain

end
