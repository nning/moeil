class SessionsController < Devise::SessionsController

  before_filter :prepare_params, only: :create

private

  def prepare_params
    mp = params[:mailbox]

    mp[:username], domain = mp.delete(:email).split('@')

    domain ||= Settings.default_domain
    mp[:domain_id] = Domain.where(name: domain).first.try(:id)
  end

  def sign_in_params
    devise_parameter_sanitizer.for(:sign_in) << :email
    super
  end

end
