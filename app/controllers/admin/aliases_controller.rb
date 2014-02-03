class Admin::AliasesController < Admin::AddressesController

  load_and_authorize_resource :alias, through: :domain


  private

  def permitted_params
    params.permit \
      :domain_id,
      alias: [
        :active,
        :description,
        :domain_id,
        :goto,
        :username
      ]
  end

end
