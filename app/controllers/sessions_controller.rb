class SessionsController < Devise::SessionsController

  before_filter :prepare_params, only: :create

private

  def prepare_params
    pm = params[:mailbox]

    pm[:username], domain = pm[:email].split('@')

    if domain.nil?
      pm[:domain_id] = Domain.where(name: Settings.default_domain).first.try(:id)
    else
      pm[:domain_id] = Domain.where(name: domain).first.try(:id)
    end
  end

end
