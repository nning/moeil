class Admin::AliasesController < Admin::AddressesController
  load_and_authorize_resource :alias, through: :domain

  def new
    if spam?
      @alias = parent.aliases.build \
        username: Password.random(Settings.spam_alias_username_length, true),
        goto: current_mailbox.email,
        description: 'Spam alias for ...'
    else
      super
    end
  end

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

  helper_method :spam?
  def spam?
    params[:spam]
  end
end
