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

  helper_method :spam?
  def spam?
    params[:spam]
  end
end
