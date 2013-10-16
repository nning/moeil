class SessionsController < Devise::SessionsController

  before_filter :prepare_params, only: :create

  # TODO XXX THIS IS A VERY DIRTY WORKAROUND!!
  def create
    # Manually do the Mailbox lookup, because I could not get
    # warden.authenticate! to work.
    #
    # Original line was this one (http://is.gd/yAipp2):
    #   self.resource = warden.authenticate!(auth_options)
    #
    self.resource = Mailbox.lookup(sign_in_params[:username], sign_in_params[:domain_id])

    if resource.nil? or not resource.valid_password? sign_in_params[:password]
      redirect_to new_mailbox_session_path, flash: { error: 'Invalid email or password.' }
      return
    end

    # From here it's original devise code again..
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end


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
