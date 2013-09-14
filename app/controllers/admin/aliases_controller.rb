class Admin::AliasesController < Admin::AliasesAndMailboxesController

  load_and_authorize_resource :alias, through: :domain

end
