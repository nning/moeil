# Sessions controller.
class SessionsController < Devise::SessionsController
  before_filter :prepare_params, only: :create

  # TODO XXX THIS IS A VERY DIRTY WORKAROUND!!
  if Settings.dirty_rails4_warden_workaround
    # Authenticate user and create a session.
    def create
      # Manually do the Mailbox lookup, because I could not get
      # warden.authenticate! to work.
      #
      # Original line was this one (https://is.gd/sweaya):
      #   self.resource = warden.authenticate!(auth_options)
      #
      self.resource = Mailbox.lookup(sign_in_params[:username], sign_in_params[:domain_id])

      if resource.nil? or not resource.valid_password? sign_in_params[:password]
        redirect_to [:new, :mailbox_session], flash: { error: 'Invalid email or password.' }
        return
      end

      # From here it's original devise code again..
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  private

  # Convert email attribute to domain_id and username.
  def prepare_params
    mp = params[:mailbox]

    mp[:username], domain = mp.delete(:email).split('@')

    domain ||= Settings.default_domain
    mp[:domain_id] = Domain.where(name: domain).first.try(:id)
  end
end
