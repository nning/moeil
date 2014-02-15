class Admin::AliasesController < Admin::AddressesController
  load_and_authorize_resource :alias, through: :domain
end
