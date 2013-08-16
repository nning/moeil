class PasswordsController < ApplicationController

  skip_authorization_check

  def update
    unless params[:password1].nil?
      if params[:password1] == params[:password2]
        @hash = Devise::Encryptable::Encryptors::Sha512Dovecot.digest \
          params[:password1], nil, Password::Sha512Crypt.generate_salt, nil
      else
        flash[:error] = 'Passwords missmatch.'
        redirect_to password_path
      end
    end
  end

end
