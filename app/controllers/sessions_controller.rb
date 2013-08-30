class SessionsController < Devise::SessionsController

  before_filter :prepare_params, only: :create

  def new
    @mailbox = Mailbox.new
  end

private

  def prepare_params
    mp = params[:mailbox]

    mp[:username], domain = mp.delete(:email).split('@')

    domain ||= Settings.default_domain
    mp[:domain_id] = Domain.where(name: domain).first.try(:id)
  end

  def sign_in_params
    params.require(:mailbox).permit(:domain_id, :email, :username, :password)
  end

end
