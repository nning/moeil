# Sessions controller.
class SessionsController < Devise::SessionsController

  before_filter :prepare_params, only: :create

  private

  # Convert email attribute to domain_id and username.
  def prepare_params
    pm = params[:mailbox]

    pm[:username], domain = pm[:email].split('@')

    pm[:domain_id] = if domain.nil?
      Domain.where(name: Settings.default_domain).first.try(:id)
    else
      Domain.where(name: domain).first.try(:id)
    end

    pm.delete(:email)
  end

end
